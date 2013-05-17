---
layout: post
title: The curious case of statsd and netcat
tags: statsd networking
---
At [GDS][] we are using [statsd][], a great tool from etsy for
aggregating statistics and submitting them to [graphite][]. I was
interrogating statsd about which counters it currently knew about,
by piping the output of an echo command into netcat, as suggested in
the [statsd management interface documentation][statsd-mgmt]:

    $ echo counters | nc localhost 8126

This worked most of the time, giving output such as:

    $ echo counters | nc localhost 8126
    { 'statsd.packets_received': 1,
      'statsd.bad_lines_seen': 1,
      foo: 0,
      bar: 0,
      baz: 1337 }
    END

However, occasionally it would fail, giving no output at all:

    $ echo counters | nc 10.0.0.1 8126
    $

and moreover, whenever this happened, statsd had died:

    events.js:72
            throw er; // Unhandled 'error' event
                  ^
    Error: write EPIPE
        at errnoException (net.js:883:11)
        at Object.afterWrite (net.js:700:19)

What was going on? To find out, I had to go on a journey through TCP
low level internals.

## TCP basics

[TCP][] is a transport-layer protocol of the internet. It presents an
abstraction which appears to be a bidirectional continuous stream of
bytes sent between two nodes on a network. This link is known as a
*connection*, and is uniquely identified by four things: the source
address and port, and the destination address and port.

A TCP connection is bidirectional; many of the control aspects of TCP
can be understood as applying to one or other sides of the connection.
For example, consider well-known "three-way handshake":

 1. Client sends SYN
 2. Server sends SYN/ACK
 3. Client sends ACK

This can be seen as two separate channels being created. First, the
client sends a SYN to set up the client&rarr;server channel, which the
server ACKs. The server then sends a SYN to set up the
server&rarr;client channel, which is ACKed by the client. The server's
ACK of the client&rarr;server channel can be sent at the same time as
the SYN to create the server&rarr;client channel, shortening this from
four steps to three. (This mental model, of two independently created
channels, also works for the lesser-used "simultaneous open" mode:
both peers send SYN packets simultaneously, and both respond with
SYN/ACKs simultaneously. Since both sides of the connection have now
been ACKed, the connection is established.)

Similarly, a TCP connection is torn down one side at a time. Alice
sends a FIN packet to Bob to state that they will not send any more
data along their side of the connection. However, Bob is free to
continue to send data back to Alice indefinitely, and the connection
does not need to close until Bob sends his FIN packet to terminate his
side. It looks like this:

 * Alice and Bob have an established connection
 * Alice sends FIN to Bob, which Bob ACKs
 * Bob continues to send data to Alice
 * Bob finally sends FIN to Alice
 * Alice receives Bob's FIN, sends ACK
 * Bob receives Alice's ACK
 * Connection is now closed (I'm ignoring TIME-WAIT for simplicity)

The important thing here is the possibility of a "half closed"
connection: one where Alice has closed her side but Bob has not closed
his side. Alice can no longer talk to Bob, but Bob can talk to Alice.

Incidentally, a TCP implementator MAY perform a "half-duplex"
close, where Alice tears down her connection without waiting for Bob's
FIN packet. If Bob sends more data, Alice will not receive it. To
indicate this, she sends a RST packet to Bob to indicate that the data
was not received correctly. This is documented in [RFC1122][], section
4.2.2.13.

## Statsd's management port

This brings us to statsd's management port. Statsd normally receives
UDP packets containing event data on port 8125, but it can expose a
TCP management interface on port 8126 to issue queries and commands
operating on statsd's internal state. The port is a simple TCP
connection, which accepts multiple commands across the lifetime of a
connection. Here is an example session:

    $ nc 10.0.0.1 8126
    counters
    { 'statsd.packets_received': 0,
      'statsd.bad_lines_seen': 0,
      foo: 0 }
    END
    
    delcounters foo
    deleted: foo
    END
    
    counters
    { 'statsd.packets_received': 0, 'statsd.bad_lines_seen': 0 }
    END

Here, I issued three commands: `counters`, `delcounters foo`, and
`counters` once more to show the effect. Statsd responded with output
to each of the commands in turn.

The fact that statsd accepts multiple commands during the life of one
connection means that statsd does not automatically close the
connection; it only closes the connection when the client closes it.

## The problem

Returning to the original problem: I issued a command to statsd using
echo and netcat. I got no output from statsd, and statsd also crashed:

    $ echo counters | nc 10.0.0.1 8126
    $

It turns out the problem is that the netcat I was using was
aggressively closing the connection in "half-duplex" fashion: it would
send the "counters" packet, send a FIN to indicate it was done, then
quit. By the time statsd had responded with its data, netcat wasn't
listening anymore, and the OS responded to statsd with a RST. Statsd
didn't handle this error, and bailed. (This was fixed in
[`324267c`][324267c], in 0.6.0).

One way I thought I could make it work was using netcat's -q
switch. This tells netcat to wait for a number of seconds before
quitting. However, this also delays netcat sending its FIN packet,
which means that the connection won't close until the end of the
timeout. This means that if I set a high timeout, such as 5 seconds,
the command will always take at least 5 seconds; on the other hand, if
I set a low timeout, such as 1 second, I run the risk of netcat
quitting before it receives the expected data. What I want, however,
is for netcat to send the FIN as soon as it reaches EOF on stdin, but
to quit after 5 seconds even if statsd hasn't closed its side of the
connection. This way, it will close quickly if statsd responds
quickly, but it will time out if statsd is too slow.

At this point, I started experimenting with different netcat
implementations on different operating systems. It turns out different
netcats actually behave differently in these circumstances.
Here is an evaluation of the systems I tried using `echo counters | nc
localhost 8126` on, both with and without `-q 5`. There is no consistency.

<table class="table">
 <caption>Summary of behaviour of different netcats</caption>
 <thead>
 <tr>
  <th>Netcat version</th>
  <th>Without -q</th>
  <th>With -q 5</th>
 </tr>
 </thead>
 <tbody>
 <tr>
  <td>Ubuntu 10.04 (OpenBSD netcat (Debian patchlevel
 1.89-3ubuntu2))</td>
  <td>Sends contents of stdin + FIN; quits immediately, doesn't wait for response</td>
  <td>Sends contents of stdin, waits 5 seconds, sends FIN and
  quits</td>
 </tr>
 <tr>
  <td>Debian 6.0 (nc [v1.10-38])</td>
  <td>Sends contents of stdin, waits for response. Never sends FIN (ie
  leaves connection open).</td>
  <td>Sends contents of stdin + FIN; waits for either FIN from statsd,
  or 5 seconds, whichever comes first, and quits</td>
 </tr>
 <tr>
  <td>Mac OS X 10.6 (nc -h gives no version info)</td>
  <td>Sends contents of stdin + FIN; waits for statsd to respond and
  close connection before quitting</td>
  <td>Does not support the -q option.</td>
 </tr>
 </tbody>
</table>

It seems that of the three netcat implementations I tested, they were
all different in some way. The OS X nc seems most convenient -- it
always closes the outgoing connection fast, but waits for the incoming
data rather than quitting immediately. However, the lack of a timeout
is dangerous -- without one, if statsd hangs, you will hang too. The
Ubuntu nc is most painful -- you need to guess a timeout, but since
you will always wait for the full timeout, you are punished for
allowing a safety margin. And the debian nc is inconsistent: sometimes
is closes the outgoing connection fast, and sometimes it doesn't,
depending on whether you set the -q option.

Overall, the most convenient for screwing around is the OS X nc; but
I would suggest the most robust usage is debian nc with a timeout set.

The ubuntu nc is singularly unfit for usage with echo in this
way. What's amusing is that their man page even recommends this usage:

    $ echo -n "GET / HTTP/1.0\r\n\r\n" | nc host.example.com 80
    
It also misses the -e option from echo to actually interpret the
control characters correctly. If you try this with ubuntu nc against
any but the fastest server, you won't get a response:

    $ # ubuntu 10.04
    $ echo -en "GET / HTTP/1.0\r\n\r\n" | nc www.google.com 80
    $

As compared to the expected behaviour:

    $ # debian 6.0
    $ echo -en "GET / HTTP/1.0\r\n\r\n" | nc www.google.com 80
    HTTP/1.0 302 Found
    Location: http://www.google.co.uk/
    Cache-Control: private
    Content-Type: text/html; charset=UTF-8
    #...etc...

## Summary

There are many flavours of nc out there, each with slightly different
treatments of how to close a TCP connection. If you're getting
unexpected behaviour from piping echo into netcat, it may be due to
odd connection teardown in your netcat.

[324267c]: https://github.com/etsy/statsd/commit/324267c527133b97f8902f4479af676bc0d7ce58
[GDS]: http://digital.cabinetoffice.gov.uk/
[graphite]: http://graphite.readthedocs.org/
[RFC1122]: http://tools.ietf.org/html/rfc1122
[statsd]: https://github.com/etsy/statsd
[statsd-mgmt]: https://github.com/etsy/statsd/blob/master/docs/admin_interface.md
[TCP]: http://en.wikipedia.org/wiki/Transmission_Control_Protocol
