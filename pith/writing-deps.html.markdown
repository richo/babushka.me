---
layout: "/_layout.html.erb"
title: Writing deps
---


## The Idea

It's all very well to run `babushka blah` and have it do jobs for you, but the real power is in babushka's ability to automate whatever chore you want, not just ones that others have thought of already.


## A dep, you say?

Dep is short for dependency -- one single piece of a larger task. A little nugget of code that does just one thing, and does it right.

Deps hook together by requiring each other. When you run babushka you specify a dep as an entry point, and babushka processes it and its requirements as a tree.


## Just show me a dep for crying out loud

Here's a babushka dep, at its most generic.

    dep 'name', :argument do
      requires 'other deps'.with('args'), 'whatever they might be'
      met? {
        # is this dependency already met?
      }
      meet {
        # this code gets run if it isn't.
      }
    end

The interaction between `met?` and `meet` defines babushka.

`met?` is an idempotent block of code that returns true if the dep is "met" -- that is, if its job is already done.

`meet` does the dep's job unconditionally. Its return value is ignored.


## How met? and meet behave

When a dep is run, its `met?` block is called. If it returns true, then there's nothing to do.

If it's unmet, though, then `meet` is run (and its return value ignored), and then `met?` is run again to see if running meet caused the dep to become met.

The idea is that `met?` and `meet` are separate concerns: running `meet` to cause `met?` to return true is like adding the code to make a failing test pass.

This implies an important part of the design: the `met?` block shouldn't just directly check that `meet` did a piece of work -- it should check for the result of that work. For example:

- If `meet` starts the webserver, then `met?` should check there's something listening on port 80.
- If `meet` bundles your app, then `met?` should run `bundle --check`.
- If `meet` exports a variable in your shell config, then `met?` should fork a shell and check it's set.


## Think of it like writing tests

If `meet` is the bit you'd write anyway, in a rake task, say, then `met?` is the corresponding test. There are a few implications

The idea is to keep a clean separation between `met?` and `meet`: the code in `met?` should do nothing except just check whether the dep is met and return a boolean, and `meet` should unconditionally satisfy the dep without doing any checks.






## Context

When you're writing a dep, you don't have to think about context at all, just one little task in isolation. As long as your `requires` are correct, you can leave the overall structure to babushka and just write each little dep separately.

When you invoke the dep, babushka uses the `requires` in each dep to assemble a tree of deps and achieve the end goal you're after.


## Re-using Other Deps

TODO

## Meta Deps / Templates

TODO

## Templated Deps

TODO
