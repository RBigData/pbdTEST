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



#' @export
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
    # spacepadcat("\r")
    spacepadcat(paste0("\rAll ", ntests, " test", punct$plural, " passed!"))
  }
  
  catfun("\n\n")
  
#  if (is.loaded("spmd_gather_integer"))
#    finalize()
  
  cleanup()
  
  invisible()
}
