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

Deps can run any ruby code. Since ruby can shell out, a dep can run any code at all. A maliciously written dep could add your machine to a botnet, or email your ssh key to a mobster, or anything crafty or untoward you can think of.

(This is true of any code you run on your machine. If you run it, you're trusting it.)

Babushka has no security features at all. This is by design, because the only real type of security is a network of trust. As Linus Torvalds said, "anything else is masturbation".

The upshot: Only run deps written by people you trust to get them right, or deps whose code you've inspected beforehand.

In particular, `--dry-run` is not a contract; it's an honour system. A badly written dep could still change your system even when you use `--dry-run`.

Dep sources are shared using git, so you can rely on their immutability once you've checked the refs, like any git repo.


## Dep Locations

There are three standard locations that babushka will search within to find deps.

- The core deps that are bundled with babushka are found at `/usr/local/babushka/deps` (or within the `deps/` directory of your custom install path, if you used one). This is a fixed set of deps; they're the bare minimum required to install babushka itself, along with its dependencies like git, and to check for system stuff like package managers.

- You can put your own personal deps in `~/.babushka/deps`. Babushka will load that path as a source, so the deps within that directory will always be available. There's no need to, but I recommend you make `~/.babushka/deps` a git repo. It's a good idea to use git to manage your personal deps, and if you like, you can push them to github for others to use. (Mine are [here](http://github.com/benhoskings/babushka-deps).)

- The `./babushka-deps/` directory, i.e. within the current directory, will also be loaded as a source. This is a good place to put project-specific deps -- whenever you're in the project's root directory (in the root of a rails project, for example), babushka will make the deps within `babushka-deps/` available.

Babushka will find deps in those locations by default. Other deps -- ones published by other people, for example -- are found in dep sources.


## Dep Sources

A dep source is just a git repo, with some deps in it. There's no structure to a dep source - the `.rb` files within it can have any names and be within any directory structure you like.

As a convention, I tend to keep related deps together in top-level `.rb` files, and use a top-level `templates/` directory for meta deps. But the layout of the files and directories doesn't affect the way babushka makes the deps & templates available, so use whatever convention you like.

Read more about dep sources, and using the deps they contain, in [the 'running' section](/running).
