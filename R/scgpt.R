#' scGPT
#' 
#' This package runs scGPT.
#' 
#' @export
Run_scGPT <- function() {
  on.exit(basilisk::basiliskStop(.scgpt))
  basilisk::basiliskRun(.scgpt, function() {
    sg <- reticulate::import("scgpt")
    message("scGPT is loaded")
    return(TRUE)
  })
}