---
layout: "/_layout.html.erb"
title: Installing babushka
---

You can install babushka on your system, no matter what state it's in, using `babushka.me/up`. That's a script that knows enough to install ruby if required (babushka's only runtime dependency), and then download a temporary babushka that knows how to do the proper install.

To use `babushka.me/up`, all you need is something like curl or wget, that can fetch over http. Mac OS X and some Linux distros have `curl`:

    bash -c "`curl babushka.me/up`"

Some other Linux distros have `wget` instead:

    bash -c "`wget -O - babushka.me/up`"


## What it does

- Installs ruby & curl via your package manager, as required
- Downloads a tarball of babushka from github
- Runs `babushka babushka` to do the actual install, which:
  - Installs git via your package manager, as required
  - Clones the babushka repo to `/usr/local/babushka`, or whatever you choose
  - Symlinks the binary to `/usr/local/bin`


## Scripting the install

The bootstrap script prompts for confirmation and an install prefix. If you're scripting the install, fear not: it runs unconditionally, accepting the defaults for those prompts, if STDIN isn't attached to a terminal. If you'd like to run a prompt-less install at the terminal, just attach `STDIN` to `/dev/null` instead:

    bash -c "`curl babushka.me/up`" </dev/null


## Versions

You can pass a git ref to `babushka.me/up` to install a different babushka version. The default is `master`.

    bash -c "`curl babushka.me/up/<ref>`"

You can supply any ref that github serves as a tarball. Some common ones:

- `master` is the latest stable version (perhaps with a small hotfix or two). I merge to master when I bump the version number, and it always fast-forwards.
- `next` is the development tip. I develop on `next` locally, and push when the specs are green. This branch won't necessarily fast-forward.


## gem or it didn't happen

Even though babushka is a ruby app, there's no gem distribution. The reason for this is that setting up a particular ruby build, rubygems, and maybe rvm or rbenv along the way is just the kind of thing babushka is good at. So in the interests of consistency, there's just one install method, which requires only `curl`.


## Dependencies

Babushka itself has just one extra requirement alongside `ruby` and `curl`, which is `git`. The install process takes care of installing git on your system if you don't already have it. On Linux, babushka will use the system's package manager; on OS X, the binary package from git-scm.com (otherwise installing babushka would require Xcode).

The bootstrapper is pretty simple. All it does is install ruby and git as required (using the system's package manager; recent OS X systems already have both installed), download a tarball of babushka, and run `babushka babushka`, which kicks off a built-in recipe that installs babushka for real. Meta, eh?

If you'd prefer to install manually or just check out the code, check [the github page](http://github.com/benhoskings/babushka) for the repo URL.
