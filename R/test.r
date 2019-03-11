depthpadding <- function()
{
  paste0(rep("  ", (getdepth()-1L)*2L), collapse="")
}



#' @export
test <- function(name, expr, check.attributes=TRUE, time=FALSE, print.on.fail=FALSE)
{
  getvars()
  catfun(paste0("\r", depthpadding(), "* ", name, ":  "))
  
  expr_text <- deparse(substitute(expr))
  
  if (time)
  {
    expr_text[2] <- paste(".__ta <- system.time({a <-", expr_text[2], "})[3]")
    expr_text[3] <- paste(".__tb <- system.time({b <-", expr_text[3], "})[3]")
  }
  else
  {
    expr_text[2] = paste("a <-", expr_text[2])
    expr_text[3] = paste("b <-", expr_text[3])
  }
  
  expr <- parse(text=expr_text)
  
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
      printfun(.__ta)
      printfun(.__tb)
    }
  }
  else
    catfun("Ok!")
  
  Sys.sleep(0.2)
  invisible()
}
