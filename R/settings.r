#' @exportx
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

