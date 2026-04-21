#' scGPT
#' 
#' This package runs scGPT.
#' @param h5ad_file file that points to the location of a h5ad file with the
#'   count data
#' @param model_dir directory with the model. This should be a directory that
#'   the scGPT model, consisting of a `.pt` file with the model, as well as the
#'   `vocab.json` and `args.json` file.
#' @param gene_col The gene column name
#' @param batch_size The batch size passed to `scg.tasks.embed_data` (default 64)
#' @details
#' This function runs the `scg.tasks.embed_data` function
#'
#'
#' @export
Run_scGPT <- function(h5ad_file, model_dir, gene_col, batch_size = 64L) {
  proc <- basilisk::basiliskStart(.scgpt)
  on.exit(basilisk::basiliskStop(proc))
  basilisk::basiliskRun(proc, function(h5ad_file, model_dir, gene_col, batch_size) {
    reticulate::import("os")
    sg <- reticulate::import("scgpt")
    message("scGPT is loaded")
    # read data into an anndata
    sc <- reticulate::import("scanpy")
    adata <- sc$read_h5ad(h5ad_file)
    
    ref_embed_adata <- sg$tasks$embed_data(
      adata,
      model_dir,
      gene_col = gene_col,
      batch_size = as.integer(batch_size)
    )
    return(ref_embed_adata$obsm[["X_scGPT"]])
  }, h5ad_file = h5ad_file, model_dir = model_dir, gene_col = gene_col, batch_size = batch_size)
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