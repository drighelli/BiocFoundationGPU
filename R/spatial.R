#' Run_novae
#' 
#' This function runs Novae
#' 
#' @export
Run_novae <- function() {
  proc <- basilisk::basiliskStart(.novae)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function() {
    sg <- reticulate::import("novae")
    message("Novae was loaded!")
    return(TRUE)
  })
}

#' Run_nimbus
#' 
#' This functions runs Nimbus.
#' 
#' @export
Run_nimbus <- function() {
  proc <- basilisk::basiliskStart(.nimbus)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function() {
    sg <- reticulate::import("nimbus_inference")
    message("nimbus_inference was loaded!")
    return(TRUE)
  })
}
  
  