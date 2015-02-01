---
layout: post
title: 'The git pickaxe'
tags:
  - git
  - pickaxe
date: 2014/02/09

---

I care a lot about commit messages. I try to write them following
[Tim Pope's example](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html),
using a short summary line, followed by one or more paragraphs of
explanation. It's not unusual for my commit message to be longer than
the diff. Why do I do this? Is it just some form of OCD? After all,
who really reads commit messages?

The reason I care about commit messages is because I'm an avid user of
the git pickaxe. If I'm ever confused about a line of code, and I want
to know what was going through the mind of the developer when they
were writing it, the pickaxe is the first tool I'll reach for. For
example, let's say I was looking at
[this line](https://github.com/gds-operations/puppet-graphite/blob/778da32e3e1e735a7aecdcfbc603477b16b9527d/templates/upstart/carbon-cache.conf#L15)
from our puppet-graphite module:

> `exec <%= @root_dir %>/bin/carbon-cache.py --debug start`

That --debug option looks suspect. I might think to myself: "Why are
we running carbon-cache in --debug mode? Isn't that wasteful? Do we
capture the output? Why was it added in the first place?" In order to
answer these questions, I'd like to find the commit that added the
switch. I could run
[git blame](https://github.com/gds-operations/puppet-graphite/blame/778da32e3e1e735a7aecdcfbc603477b16b9527d/templates/upstart/carbon-cache.conf#L15)
on the file, to find the last commit that touched the line. However
that leads to a
[totally unrelated commit](https://github.com/gds-operations/puppet-graphite/commit/778da32e3e1e735a7aecdcfbc603477b16b9527d)
that had nothing to do with my --debug flag issue.

So I still want to find the commit that added that --debug switch, but
git blame has got me nowhere. What next? It turns out there's an
option to git log which will find any commit which introduces or
removes a string from anywhere in its commit:

> `git log -p -S --debug`

This will show me every commit that either introduced or removed the
string `--debug`. (It's a slightly confusing example, because --debug
is not being used as a command-line switch to git, but as a string
argument to the `-S` switch instead. Nevertheless, git does the right
thing.) The `-p` switch shows the commit diff as well. There are in
fact a few matches for this search, but the third commit that comes up
is the winner:

    commit 5288d5804a3fc20dae4f3b2deeaa7f687595aff1
    Author: Philip Potter <philip.g.potter@gmail.com>
    Date:   Tue Dec 17 09:33:59 2013 +0000

        Re-add --debug option (reverts #11)

        The --debug option is somewhat badly named -- it *both* adds debug
        output, *and* causes carbon-cache to run in the foreground. Removing the
        option in #11 caused the upstart script to lose track of the process as
        carbon-cache started unexpectedly daemonizing.

        Ideally we want to have a way of running through upstart without the
        debug output, but this will fix the immediate problem.

    diff --git a/templates/upstart/carbon-cache.conf b/templates/upstart/carbon-cache.conf
    old mode 100644
    new mode 100755
    index 43a16ee..2322b2d
    --- a/templates/upstart/carbon-cache.conf
    +++ b/templates/upstart/carbon-cache.conf
    @@ -12,4 +12,4 @@ pre-start exec rm -f '<%= @root_dir %>'/storage/carbon-cache.pid
     chdir '<%= @root_dir %>'
     env GRAPHITE_STORAGE_DIR='<%= @root_dir %>/storage'
     env GRAPHITE_CONF_DIR='<%= @root_dir %>/conf'
    -exec python '<%= @root_dir %>/bin/carbon-cache.py' start
    +exec python '<%= @root_dir %>/bin/carbon-cache.py' --debug start

Now I know exactly why `--debug` is there, and I know that I certainly
don't want to remove it. But what if my commit message had just been
"Re-add --debug option"? I'd be none the wiser. This is why I care so
much about commit messages: because I have the tools to quickly get
from a piece of code to the commit that introduced it, I spend much
more time reading commit messages.

This example is also interesting because it raises another question:
should this explanation have been in a code comment instead?  The
--debug flag is inherently confusing, and a comment could have
answered my questions even quicker by being right there in the file.

However, a 6-line comment in the file would be quite a bit of noise
whenever you *weren't* interested in the --debug switch, whereas a
commit message can be as big as it needs to be to make the explanation
clear. Comments and commit messages can be complementary: there could
be a one-line comment saying that --debug causes carbon-cache to stay
in the foreground, and a more detailed explanation in the commit
message. In some ways I see commit messages as a type of expanded
commenting system which is available at your fingertips whenever you
need it but automatically hides when you just want to read the code.

----

A couple of small postscripts: I could have even narrowed down my
search further by adding a path filter to my log command:

> `git log -p -S --debug templates/upstart/carbon-cache.conf`

This search finds the commit in question instantly: it's the first
result. But unlike the original git log command, it is not resilient
against the file being renamed in an intervening commit. I tend not to
use path filters for pickaxe searches, because I can normally find
what I want easily enough anyway.

The `-S` switch takes a string match only. If you want to match a
regex instead, you can use the `-G` switch instead.
