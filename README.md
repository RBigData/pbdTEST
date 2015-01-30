# pbdTEST

I love tests.  I hate spam.

This very simple testing suite gives some utilities for testing
whatever, without making you sift through the terminal to see what
happened.  It also tightly integrates with the pbdMPI (for use in
other pbd packages).

## Examples

Here all tests pass:

```r
library(pbdTEST)

module("main")

test("addition", {
  a <- 2
  b <- 1+1
})

test("subtraction", {
  a <- 3
  b <- 5-2
})

test("multiplication", {
  a <- 6
  b <- 3*2
})

collect()
```

This prints to the terminal:

```
#----  main  ----#

All 3 tests passed!
```

Though as the tests are being performed, each test is named, and if
it succeeds, it is overwritten in the terminal by the next test.
So for example, you would have seen

```
* subtraction:  Ok!
```

while testing the above.

It sounds more complicated than it really is.  Try it and you'll
instantly see what I mean.

It also has some useful features for diagnosing problems:

```r
library(pbdTEST)

module("main")

submodule("passing tests")
test("addition", {
  a <- 2
  b <- 1+1
})

submodule("timing tests")
test("subtraction", {
  a <- 3
  b <- 5-2
}, time=TRUE)

submodule("failing tests, printing values on error")
test("multiplication", {
  a <- 6
  b <- 3*3
}, print.on.fail=TRUE)

collect()
```

Which prints:

```
#----  main  ----#
* passing tests
* timing tests
    * subtraction:
Method a time:  0
Method b time:  0
* failing tests, printing values on error
    * multiplication:  FAILED
[1] 6
[1] 9

There was 1 error
```

