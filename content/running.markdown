---
title: Running Deps
---

Running deps with babushka is simple. The form of the dep names varies depending on where the deps are located, but the way they're run is always the same.

## Referencing Deps & Sources

If the dep you're running is within one of babushka's standard load paths (read about them [here](/finding)), then you can just reference the dep directly.

    $ babushka homebrew

There are many more deps out there, though, which you might like to use ([when you trust them!](/finding)). You can run a dep from any source that's published using babushka's convention automatically:

    $ babushka benhoskings:TextMate.app

That runs the dep called 'TextMate.app' in my source, i.e. the source that's found here:

    http://github.com/benhoskings/babushka-deps


The idea with deps, though, is to make them small and self-contained, specifying each dep's immediate requirements as a list of other deps. Babushka looks up these deps in just the same way as it looks up deps passed on the commandline.


## Passing arguments to deps

Deps are, in some ways, like a method call - the outer block of the dep is run at the point the dep is defined, which happens lazily as it is invoked from its parent, or from the commandline if it's the top-level dep.

Like methods, deps can have parameters, and when you call the dep, you can pass values for those parameters, just like supplying arguments to a method call.

There are more details on dep parameters in the section on [writing deps](/writing). For now, the important part is that deps can always accept arguments, whether they're run directly from the commandline, or required from another dep.

To pass arguments on the commandline, use `name=value` pairs:

    $ babushka benhoskings:push! ref=HEAD remote=production

To pass arguments to a dep when you require it, use babushka's `String#with` method.

    dep 'custom nginx config' do
      requires 'benhoskings:nginx.src'.with(version: '1.0.8')
      # ...
    end

You don't have to supply values for a dep's parameters when you call it; dep parameters can be unset, and will lazily prompt for values as required (i.e. at the point babushka attempts to use an unset parameter's value). You can find more details about dep parameters in the [writing deps](/writing) section.


## Dep source management

When running a dep from a public source, babushka first clones its repo to `~/.babushka/sources/<name>` (or if it's there already, updates it). If you like, though, you can drop any git repo into `~/.babushka/sources/`, and babushka will use it.

In particular, the only time the github URI convention is used is to clone sources that aren't already present in `~/.babushka/sources`. This means you can arrange the git repos within `~/.babushka/sources` however you like, and then use those names whenever you reference deps. Babushka will update the repos from their `origin` remote in the same way - it doesn't mind if you use a custom URI for the remote.

This system is configuration-free and it works reliably - you have total control over where each of your sources point, and babushka will fill in the gaps automatically from the default locations.


## Commandline Syntax

Babushka's commandline syntax is a subcommand & options style, similar to `git` and `gem`. To see the subcommands available, you can run

    $ babushka help

To run deps, use the "meet" subcommand, passing the dep names you're after as arguments. But "meet" is also the default subcommand, so the best way to run deps is to just pass them as arguments, straight up. For example, to run the "rubygems" dep:

    $ babushka rubygems

There are several useful options to use when running deps. The one you'll be after most regularly is `--debug`, which makes babushka much more verbose. In particular, output from long-running shell commands will be printed in realtime.

    $ babushka rubygems --debug

Two other commonly used options for "meet" are `--dry-run`, to check whether deps are met without meeting them, and `--defaults`, to run babushka non-interactively so it doesn't prompt for input at runtime.

For more details on options and arguments, see the "help" output for a specific subcommand:

    $ babushka help meet

You can abberviate subcommands as long as they remain unique. All the subcommands except 'sources' and 'search' can be abbreviated to a single letter without any ambiguity.


## The babushka console

Although babushka is predominantly a commandline app, it's not implemented that way. All the commandline functionality is available at a ruby console too:

    $ babushka console


## Using babushka as a library

All that does is start an irb session, requiring 'lib/babushka'. Everything will work as expected if you require 'lib/babushka' in a program of your own and then use babushka programatically.

The top-level methods like `dep` and `meta` won't be included by default; you can `include Babushka::DSL` to add them to whatever scope you like.

The only caveat to be aware of is that babushka does monkey-patch some convenience methods onto core classes, like `Array#collapse` and `String#p`. If babushka's primary use was as a library then I wouldn't be patching in this way, but I think it's a worthwhile tradeoff for the concise deps that the patches allow you to write.


## Source Loading

To load the source, babushka requires every `.rb` file (in an indeterminate order; `Dir.glob` is in filesystem order on Linux, not alphabetical), and stores the names and blocks for each dep. The deps themselves are defined lazily, though -- the outer block of each dep is only run as the dep itself is run. (Run with `--debug` and watch for the 'defining dep against template' messages to see for yourself.)

Meta deps are defined eagerly, but the template within a meta dep is only run when a dep is (lazily) defined against it.

So, you don't need to require any of the `.rb` files from each other in line with dep requires -- lazy dep defining always happens after source loading is complete. At that point all the files have been parsed and required, so babushka has already located all the deps in the source.


## Logs

TODO
