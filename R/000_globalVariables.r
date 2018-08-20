### This is to avoid the fale positive messages from R CMD check.
###   "no visible binding for global variable"
### Suggested by Prof Brian Ripley
### ?globalVariables

utils::globalVariables(
  c(
    "stopfun",
    "nerrors",
    "catfun",
    ".__ta",
    ".__tb",
    "a",
    "b", 
    "printfun",
    "ntests"
  )
)
