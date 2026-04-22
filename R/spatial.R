#' Run_novae
#' 
#' This function runs novae.
#' 
#' @export
Run_novae <- function(adata_path = NULL, accelerator = "cpu") {
  proc <- basilisk::basiliskStart(.novae)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function(adata_path, accelerator) {
    
    # libraries
    os    <- reticulate::import("os")
    os$environ[["HF_HOME"]]      <- ".cache/huggingface"
    os$environ[["MPLCONFIGDIR"]] <- ".cache/matplotlib"
    novae <- reticulate::import("novae")
    ad <- reticulate::import("anndata")
    np <- reticulate::import("numpy")
    sp <- reticulate::import("scipy")
    
    # read anndata
    adata <- ad$read_h5ad(adata_path)
    
    # sparse matrix
    adata$X <- sp$sparse$csr_matrix(adata$layers$counts)

    # spatial neighbors
    novae$spatial_neighbors(adata)
    
    # novae
    model <- novae$Novae$from_pretrained("MICS-Lab/novae-human-0")
    n_valid_cells <-  as.integer(adata$n_obs())
    model$swav_head$num_prototypes <- min(
      model$swav_head$num_prototypes,
      n_valid_cells %/% 2L
    )

    model$compute_representations(adata, zero_shot = TRUE, accelerator = accelerator, num_workers = 4L)
    model$assign_domains(adata)
    reticulate::py_to_r(adata)
  }, adata_path = adata_path, accelerator = accelerator)
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
  
  
