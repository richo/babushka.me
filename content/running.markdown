---
title: Running Deps
---

## Community DB

TODO

## Commandline Syntax

TODO

## Source Loading

To load the source, babushka requires every .rb file (in an indeterminate order; `Dir.glob` is in filesystem order on Linux, not alphabetical), and stores the names and blocks for each dep. The deps themselves are defined lazily, though -- the outer block of each dep is only run as the dep itself is run. (Run with `--debug` and watch for the 'defining dep against template' messages to see for yourself.)

Meta deps are defined eagerly, but the template within a meta dep is only run when a dep is (lazily) defined against it.

So, you don't need to require any of the `.rb` files from each other in line with dep requires -- lazy dep defining always happens after source loading is complete. At that point all the files have been parsed and required, so babushka has already located all the deps in the source.

## Vars

TODO

## Logs

TODO
