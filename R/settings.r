#' @export
settings = function(package)
{
  if (package == "mpi" || package == "dmat" || package == "kazaam")
  {
    if (package == "mpi")
      suppressMessages(library(pbdMPI))
    else if (package == "dmat")
    {
      suppressMessages(library(pbdDMAT))
      init.grid()
    }
    else if (package == "kazaam")
      suppressMessages(library(kazaam))
    
    printfun = function(x) pbdMPI::comm.print(x, quiet=TRUE)
    assign("printfun", printfun, envir=pbdTESTEnv)
    
    catfun = function(x) pbdMPI::comm.cat(x, quiet=TRUE)
    assign("catfun", catfun, envir=pbdTESTEnv)
    
    assign("allfun", pbdMPI::comm.all, envir=pbdTESTEnv)
    assign("stopfun", pbdMPI::comm.stop, envir=pbdTESTEnv)
  }
  else
    assign("catfun", base::cat, envir=pbdTESTEnv)
  
  invisible()
}
