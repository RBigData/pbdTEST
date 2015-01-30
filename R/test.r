settings <- function(mpi=TRUE)
{
  if (mpi)
  {
    suppressPackageStartupMessages(library(pbdDMAT))
    init.grid()
    
    printfun <- function(x) pbdMPI::comm.print(x, quiet=TRUE)
    assign("printfun", printfun, envir=pbdTESTEnv)
    
    catfun <- function(x) pbdMPI::comm.cat(x, quiet=TRUE)
    assign("catfun", catfun, envir=pbdTESTEnv)
    
    assign("allfun", pbdMPI::comm.all, envir=pbdTESTEnv)
    assign("stopfun", pbdMPI::comm.stop, envir=pbdTESTEnv)
  }
  else
    assign("catfun", base::cat, envir=pbdTESTEnv)
  
  invisible()
}



module <- function(module.name)
{
  getvars()
  catfun(paste0("#----  ", module.name, "  ----#\n"))
  setdepth(1L)
  
  invisible()
}



submodule <- function(submodule.name)
{
  getvars()
  
  spacepadcat(paste0("\r* ", submodule.name, "                                \n"))
  setdepth(2L)
  
  invisible()
}



depthpadding <- function()
{
  paste0(rep("  ", (getdepth()-1L)*2L), collapse="")
}


test <- function(name, expr, check.attributes=TRUE, time=FALSE, print.on.fail=FALSE)
{
  getvars()
  catfun(paste0("\r", depthpadding(), "* ", name, ":  "))
  
  if (time)
  {
    expr <- deparse(substitute(expr))
    
    expr[2] <- paste(".__ta <- system.time({", expr[2], "})[3]")
    expr[3] <- paste(".__tb <- system.time({", expr[3], "})[3]")
    
    expr <- parse(text=expr)
  }
  
  
  eval(expr, envir=parent.frame())
  assign("ntests", value=ntests+1L, envir=pbdTESTEnv)
  
  if (time)
    catfun(paste0("\nMethod a time:  ", .__ta, "\nMethod b time:  ", .__tb, "\n"))
  
  result <- all.equal(a, b, check.attributes=check.attributes)
  
  if (!isTRUE(result))
  {
    catfun("FAILED\n")
    assign("nerrors", value=nerrors+1L, envir=pbdTESTEnv)
    
    if (print.on.fail)
    {
      printfun(a)
      printfun(b)
    }
  }
  else
    catfun("Ok!")
  
  Sys.sleep(0.2)
  invisible()
}



spacepadcat <- function(str)
{
  getvars()
  catfun(paste0(str, paste0(rep(" ", 80-nchar(str), collapse=""), collapse="")))
}



punctuation <- function(n)
{
  if (n == 1)
  {
    tobe <- "was"
    plural <- ""
  }
  else
  {
    tobe <- "were"
    plural <- "s"
  }
  
  return(list(tobe=tobe, plural=plural))
}



collect <- function()
{
  getvars()
  
  if (nerrors > 0)
  {
    punct <- punctuation(nerrors)
    spacepadcat("\r")
    catfun(paste0("\nThere ", punct$tobe, " ", nerrors, " error", punct$plural))
  }
  else
  {
    punct <- punctuation(ntests)
    spacepadcat("\r")
    spacepadcat(paste0(" All ", ntests, " test", punct$plural, " passed!"))
  }
  
  catfun("\n\n")
  
#  if (is.loaded("spmd_gather_integer"))
#    finalize()
  
  cleanup()
  
  invisible()
}

