#' @export
module <- function(module.name)
{
  getvars()
  catfun(paste0("#----  ", module.name, "  ----#\n"))
  setdepth(1L)
  
  invisible()
}



#' @export
submodule <- function(submodule.name)
{
  getvars()
  
  spacepadcat(paste0("\r* ", submodule.name, "                                \n"))
  setdepth(2L)
  
  invisible()
}

