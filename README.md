# Space Invaders

### How to run
```
bin/find_invaders --help
Usage bin/find_invaders input [options]
    -p, --precision=s                Precision value, the number of differences to allow
        --help                       Prints help

```
Find invaders with a rather simple approximation algorithm. The number of
differences are governed by the `precision` argument: if it's set to 0 it will
detect only exact matches, if set to 5 it allows 5 differences per invader etc.

Invader file is hardcoded, it can be replaced in `inputs/invaders`

### Algorithm

The finder reads the radio feed line-by-line and runs a scan for each invader.
For each scan, the radio feed is segmented into invader-width chunks and a simple
comparision is run.
The only caveat here is that the very first line of the invader has to be found
in the radio feed as an exact match. I took this approach to save on time as this
greately speeds up on the search.
False positives are discarded when the number of differences is too high.

At the end, the radio feed is printed again with the spotted invaders highlighted
in blue.

### Commit log

The commits are not squashed on purpose to show how the various classes have
emerged during implementation/testing, how the method names adopted more and more
the language of the domain.
