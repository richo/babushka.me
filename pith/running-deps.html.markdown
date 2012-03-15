---
layout: "/_layout.html.erb"
title: Running Deps
---

Running deps with babushka is simple. The form of the dep names varies depending on where the deps are located, but the way they're run is always the same.

## Referencing Deps & Sources

If the dep you're running is within one of babushka's standard load paths (read about them [here](/finding-deps)), then you can just reference the dep directly.

    $ babushka homebrew

There are many more deps out there, though, which you might like to use ([when you trust them!](/finding-deps)). You can run a dep from any source that's published using babushka's convention automatically:

    $ babushka benhoskings:TextMate.app

That runs the dep called 'TextMate.app' in my source, i.e. the source that's found here:

    http://github.com/benhoskings/babushka-deps


The idea with deps, though, is to make them small and self-contained, specifying each dep's immediate requirements as a list of other deps. Babushka looks up these deps in just the same way as it looks up deps passed on the commandline.


## Passing arguments to deps

Deps are, in some ways, like a method call - the outer block of the dep is run at the point the dep is defined, which happens lazily as it is invoked from its parent, or from the commandline if it's the top-level dep.

Like methods, deps can have parameters, and when you call the dep, you can pass values for those parameters, just like supplying arguments to a method call.

There are more details on dep parameters in the section on [writing deps](/writing-deps). For now, the important part is that deps can always accept arguments, whether they're run directly from the commandline, or required from another dep.

To pass arguments on the commandline, use `name=value` pairs:

    $ babushka benhoskings:push! ref=HEAD remote=production

To pass arguments to a dep when you require it, use babushka's `String#with` method.

    dep 'custom nginx config' do
      requires 'benhoskings:nginx.src'.with(version: '1.0.8')
      # ...
    end

You don't have to supply values for a dep's parameters when you call it; dep parameters can be unset, and will lazily prompt for values as required (i.e. at the point babushka attempts to use an unset parameter's value). You can find more details about dep parameters in the [writing deps](/writing-deps) section.
