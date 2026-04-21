library(BiocFoundationGPU)
library(reticulate)

reticulate::use_virtualenv("kronos_env")

# cp <- reticulate::import_from_path("kronos.utils", path = "CellPhenotyping")
kr <- reticulate::import("kronos")