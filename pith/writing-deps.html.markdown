---
layout: "/_layout.html.erb"
title: Writing deps
---


## The Idea

It's all very well to run `babushka blah` and have it do jobs for you, but the real power is in babushka's ability to automate whatever chore you want, not just ones that others have thought of already.


## Context

When you're writing a dep, you don't have to think about context at all, just one little task in isolation. As long as your `requires` are correct, you can leave the overall structure to babushka and just write each little dep separately.

When you invoke the dep, babushka uses the `requires` in each dep to assemble a tree of deps and achieve the end goal you're after.


## Re-using Other Deps

TODO


## Meta Deps / Templates

TODO


## Templated Deps

TODO
