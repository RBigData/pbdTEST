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

