---
layout: "/_layout.html.erb"
title: Installing babushka
---

You can install babushka on your system, no matter what state it's in, using `babushka.me/up`. That's a script that knows enough to install ruby if required (babushka's only runtime dependency), and then download a temporary babushka that knows how to do the proper install.

To use `babushka.me/up`, all you need is something like `curl` or `wget`, that can fetch over http. Mac OS X has `curl`:

    bash -c "`curl babushka.me/up`"

Many Linux distros, including Ubuntu, have `wget` instead:

    bash -c "`wget -O - babushka.me/up`"

It's a nice way to kick things off on a new server, or on your new laptop, since it can literally be the first command you run on the machine. In a few commands' time you can have your commandline all set up, or your favourite apps installed, or whatever other task you write a recipe for.

You can pass comma-separated options to `babushka.me/up` to customise the install. There are two that are currently supported:

- `next`, to checkout the latest code on the 'next' branch instead of the stable 'master' one;
- `hard`, to run the installer without asking for any input or confirmation, which is useful when scripting the install.

Here are a couple of examples using those options.

    bash -c "`curl babushka.me/up/hard`"

    bash -c "`wget -O - babushka.me/up/next,hard`"

Even though babushka is a ruby application, there's no gem distribution. The reason for this is that setting up a particular ruby build, rubygems, and maybe rvm or rbenv along the way is just the kind of thing babushka is good at. So in the interests of consistency, there's just one install method, which doesn't require anything other than something like `curl` or `wget`.

Babushka itself has just one extra requirement alongside `ruby` and `curl`/`wget`, which is `git`. The install process takes care of installing git on your system if you don't already have it. On Linux, babushka will use the system's package manager; on OS X, the binary package from git-scm.com (otherwise installing babushka would require Xcode).

The bootstrapper is pretty simple. All it does is install ruby and git as required (using the system's package manager; recent OS X systems already have both installed), download a tarball of babushka, and run `babushka babushka`, which kicks off a built-in recipe that installs babushka for real. Meta, eh?

If you'd prefer to install manually or just check out the code, check [the github page](http://github.com/benhoskings/babushka) for the repo URL.