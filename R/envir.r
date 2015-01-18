pbdTESTEnv <- new.env()

assign("depth", 0L, envir=pbdTESTEnv)
assign("nerrors", 0L, envir=pbdTESTEnv)
assign("ntests", 0L, envir=pbdTESTEnv)

assign("catfun", base::cat, envir=pbdTESTEnv)
assign("allfun", base::all, envir=pbdTESTEnv)
assign("stopfun", base::stop, envir=pbdTESTEnv)



getvars <- function()
{
  assign("nerrors", get("nerrors", envir=pbdTESTEnv), envir=parent.frame())
  assign("ntests", get("ntests", envir=pbdTESTEnv), envir=parent.frame())
  
  assign("catfun", get("catfun", envir=pbdTESTEnv), envir=parent.frame())
  assign("allfun", get("allfun", envir=pbdTESTEnv), envir=parent.frame())
  assign("stopfun", get("stopfun", envir=pbdTESTEnv), envir=parent.frame())
}

cleanup <- function()
{
  assign("nerrors", 0L, envir=pbdTESTEnv)
  assign("ntests", 0L, envir=pbdTESTEnv)
}

setdepth <- function(n)
{
  assign("depth", n, envir=pbdTESTEnv)
  TRUE
}

getdepth <- function(n)
{
  get("depth", envir=pbdTESTEnv)
}

checkdepth <- function()
{
  getvars()
  if (getdepth() == 0)
    stopfun("You must declare a module first via module()")
}
