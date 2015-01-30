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

