depthpadding <- function()
{
  paste0(rep("  ", (getdepth()-1L)*2L), collapse="")
}



#' @export
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

