#' scGPT
#' 
#' This package runs scGPT.
#' 
#' @export
Run_novae <- function() {
  proc <- basilisk::basiliskStart(.novae)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function(file) {
    sg <- reticulate::import("novae")
    message("Novae was loaded!")
    return(TRUE)
  }, file = file)
}