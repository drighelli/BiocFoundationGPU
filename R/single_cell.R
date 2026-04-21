#' scGPT
#' 
#' This package runs scGPT.
#' 
#' @export
Run_scGPT <- function() {
  proc <- basilisk::basiliskStart(.scgpt)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function() {
    sg <- reticulate::import("scgpt")
    message("scGPT is loaded")
    return(TRUE)
  })
}

#' scfoundation
#' 
#' This package runs scfoundation
#' 
#' @export
Run_scfoundation <- function() {
  proc <- basilisk::basiliskStart(.scfoundation)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function() {
    sg <- reticulate::import("scfoundation")
    message("scfoundation is loaded")
    return(TRUE)
  })
}