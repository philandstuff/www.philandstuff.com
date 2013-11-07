---
layout: post
title: Automating dnsmasq and resolvconf
tags:
  - networking
  - dnsmasq
  - resolvconf
  - puppet
---

I've been working a lot with [dnsmasq][] for DNS forwarding recently,
and have hit enough problems that I thought it would be worth writing
about them.

On my current project, we're using Ubuntu 12.04, which uses dnsmasq as
a local DNS cacher and forwarder, and [resolvconf][] (the service as
opposed to the resolv.conf file) to manage DNS server configuration.

## dnsmasq

Dnsmasq is a simple DNS forwarder. It proxies multiple upstream DNS
servers, add caching, and can even serve up A records from an
`/etc/hosts`-style configuration file.

Dnsmasq is configured by giving it an `/etc/resolv.conf`-style file
with a list of nameservers. It will regularly poll this file for
changes, and change its forwarding behaviour accordingly.

Dnsmasq can also be configured to direct requests for particular
domains to particular servers; for example, if you want everything in
mycompany.com to go to your internal office server, but everything
else to go to public DNS servers, dnsmasq can do that for you.

Dnsmasq does NOT perform recursive DNS lookups; you will still need
some form of recursive DNS server in order to achieve full DNS
functionality.

## resolvconf

resolvconf is part of the ubuntu-minimal install, which means that
it's considered a pretty core part of the distribution these
days. It's an evolution from the traditional `/etc/resolv.conf` file,
which lists nameservers and search domains to use when resolving DNS
names to IP addresses.

You associate a nameserver with a particular network interface with a
line such as:

    echo nameserver 192.0.2.6 | resolvconf -a IFACE.PROGNAME

where IFACE is an interface, and PROGNAME is the name of an associated
program. For example, dnsmasq itself registers itself with resolvconf
by associating with the lo.dnsmasq entry. You can remove entries with
`resolvconf -d`. Generally, you don't call resolvconf directly;
instead, it is called automatically as part of bringing up a network
interface, or starting a DNS service, or similar.

Each time an interface is added or removed, resolvconf updates
associated configuration files by running scripts in the
`/etc/resolvconf/update.d` directory; one of these, `libc`, updates
the traditional `/etc/resolv.conf` file.

## The problem

This is where I get to the problem I was facing. I was trying to
install and configure dnsmasq in a puppet run. However, immediately
after dnsmasq was installed, I would start getting name resolution
errors, and the rest of the puppet run would fail. But by the time I
had logged onto the box to investigate, name resolution was working
again! What was going on?

It turns out there's a bit of a race condition when starting dnsmasq,
particularly for the first time. What happens is this:

1. /etc/init.d/dnsmasq starts the dnsmasq daemon. Dnsmasq, in its
   default configuration on ubuntu, looks for upstream nameservers in
   /var/run/dnsmasq/resolv.conf. Dnsmasq checks for the file, finds it
   missing, and gives up for the moment. It will poll again later.
2. Once dnsmasq has started and returned, the init.d script registers
   127.0.0.1 with lo.dnsmasq in resolvconf.
3. resolvconf runs its updates, generating configuration for dnsmasq
   in /var/run/dnsmasq/resolv.conf and also changing the standard libc
   resolver file /etc/resolv.conf to *only* refer to 127.0.0.1, the
   dnsmasq process
4. At this point, the dnsmasq service is the sole DNS server that the
   local resolver can see, but dnsmasq itself hasn't yet seen any
   upstream nameservers. Therefore it can't give any useful answers.
   At this point, my puppet run starts failing.
5. After a few seconds, dnsmasq polls the /var/run/dnsmasq/resolv.conf
   file again and finally finds the upstream nameservers left for it
   by resolvconf in step #3 above.
6. I log into the machine, try to resolve a name, and everything
   works.

I have [filed a bug][] at launchpad to raise this issue.


[dnsmasq]: http://www.thekelleys.org.uk/dnsmasq/doc.html
[resolvconf]: http://en.wikipedia.org/wiki/Resolvconf
[filed a bug]: https://bugs.launchpad.net/ubuntu/+source/dnsmasq/+bug/1247803
