#' @export
settings = function(package, version_min="0.2-0")
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
  
  version_current = packageVersion("pbdTEST")
  if (version_current < version_min)
    pbdTESTEnv$stopfun("minimum pbdTEST version not met")
  
  invisible()
}
