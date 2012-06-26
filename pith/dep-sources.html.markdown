---
layout: "/_layout.html.haml"
title: Dep sources
---


A dep source is just a git repo, with some deps in it. There's no structure to a dep source - the `.rb` files within it can have any names and be within any directory structure you like.

As a convention, I tend to keep related deps together in top-level `.rb` files, and use a top-level `templates/` directory for meta deps. But the layout of the files and directories doesn't affect the way babushka makes the deps & templates available, so use whatever convention you like.


## Dep source management

When running a dep from a public source, babushka first clones its repo to `~/.babushka/sources/<name>` (or if it's there already, updates it). If you like, though, you can drop any git repo into `~/.babushka/sources/`, and babushka will use it.

In particular, the only time the github URI convention is used is to clone sources that aren't already present in `~/.babushka/sources`. This means you can arrange the git repos within `~/.babushka/sources` however you like, and then use those names whenever you reference deps. Babushka will update the repos from their `origin` remote in the same way - it doesn't mind if you use a custom URI for the remote.

This system is configuration-free and it works reliably - you have total control over where each of your sources point, and babushka will fill in the gaps automatically from the default locations.


