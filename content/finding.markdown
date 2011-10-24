---
title: Finding deps
---

## Searching for Deps

Whenever a public dep is run with babushka, the result is recorded anonymously in a public database at babushka.me. You can query this database using babushka's `search` subcommand: it returns a list of matching deps, along with a measure of their popularity and reliability.

A public dep is a dep whose source has a public URL -- something like `git://` or `http://`. There's more information on dep sources in the [running](/running) section, but for now: a dep is public when you run it directly from someone's public source; otherwise, it's probably private.

To find, say, deps about coffee, run this command:

    $ babushka search coffee

You'll see a table of results returned by the web service.

The webservice has a public API that babushka accesses. You can hit the API directly if you like; the search url is `/deps/search.json/<query>`. More details are in the app's [routing table](https://github.com/benhoskings/babushka.me/blob/master/config/routes.rb).

Because it's truly anonymous, the results are gameable. Please refrain from taking advantage of that. :)

## Trust

Deps can run any ruby code. Since ruby can shell out, a dep can run any code at all. A maliciously written dep could add your machine to a botnet, or email your ssh key to a mobster, or [literally](http://literally.barelyfitz.com/) melt your face off, or anything crafty or untoward you can think of.

(This is true of any code you run on your machine. If you run it, you're trusting it.)

Babushka has no security features at all. This is by design, because the only real type of security is a network of trust. As Linus Torvalds said, "anything else is masturbation".

The upshot: Only run deps written by people you trust to get them right, or deps whose code you've inspected beforehand.

In particular, `--dry-run` is not a contract; it's an honour system. A badly written dep could still change your system even when you use `--dry-run`.

Dep sources are shared using git, so you can rely on their immutability once you've checked the refs, like any git repo.


## Dep Sources

A dep source is just a git repo, with some deps in it. There's no structure to a dep source - the `.rb` files within it can have any names and be within any directory structure you like.

As a convention, I tend to keep related deps together in top-level `.rb` files, and use a top-level `templates/` directory for meta deps. But the layout of the files and directories doesn't affect the way babushka makes the deps & templates available, so use whatever convention you like.

## Custom Sources

TODO

## Dep Locations

TODO
