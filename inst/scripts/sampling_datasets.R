library(OSTA.data)
library(SpatialExperimentIO)
library(SpatialExperiment)
library(VisiumIO)

# stored data are in a Google Drive folder, you can download them from there:
# https://drive.google.com/drive/folders/1BWWS4ThYFGXKwAGhmK_TurWVW-vs_8xU?usp=sharing
path <- "~/Downloads/HackathonFoundationExData"

# Oliveira Datasets:
## Xenium Human Colon
id <- "Xenium_HumanColon_Oliveira"
pa <- OSTA.data_load(id)
dir.create(td <- tempfile())
unzip(pa, exdir=td)
# importing
(spe <- readXeniumSXE(td))

set.seed(123)
txsamp <- sample(dim(spe)[1],100)
cellsamp <- sample(dim(spe)[2],100)
spe1 <- spe[txsamp, cellsamp]

(spe1)
dir.create(path=path, recursive = TRUE)
saveRDS(spe1, file=file.path(path, "Xenium_HumanColon_Oliveira_100tx_100cl.rds"))

## Visium Human Colon
id <- "Visium_HumanColon_Oliveira"
pa <- OSTA.data_load(id)
dir.create(td <- tempfile())
unzip(pa, exdir=td)
# importing
obj <- TENxVisium(
    spacerangerOut=td,
    images="lowres",
    format="h5")
(spe <- import(obj))
set.seed(123)

txsamp <- sample(dim(spe)[1],100)
cellsamp <- sample(dim(spe)[2],100)
spe1 <- spe[txsamp, cellsamp]
library(Matrix)
library(DelayedArray)
counts(spe1) <- as(as.matrix(counts(spe1)), "dgCMatrix")

saveRDS(spe1, file=file.path(path, "Visium_HumanColon_Oliveira_100tx_1000cl.rds"))


# CosMx dataset
id <- "CosMx1k_MouseBrain1"
tx <- FALSE
pa <- OSTA.data_load(id, mol=TRUE)
dir.create(td <- tempfile())
unzip(pa, exdir=td)
# importing
(spe <- readCosmxSXE(td, addTx=FALSE))

txsamp <- sample(dim(spe)[1],100)
cellsamp <- sample(dim(spe)[2],100)
spe1 <- spe[txsamp, cellsamp]

saveRDS(spe1, file=file.path(path, "CosMx1k_MouseBrain1_100tx_100cl.rds"))


# Janesick dataset (10x Genomics Xenium, Human Breast Cancer FFPE)

# Reference: Janesick et al., Nature Communications, 2023
# Original data:
# https://www.10xgenomics.com/datasets/xenium-ffpe-human-breast-cancer-rep1
#
# A 2500x2500 pixel crop of the original dataset was generated using the
# SpatialData Python package (spatialdata + spatialdata-io).
# The crop is centered on the tissue and covers a representative region.
#
# Three files are provided:
#   - crop_he_2500x2500.tif   : H&E image crop (RGB, 2500x2500 px)
#   - crop_spatial.h5ad       : AnnData object with cell-by-gene expression
#                               matrix and spatial coordinates (obsm[“spatial”])
#   - crop_coords.json        : bounding box of the crop in the global
#                               Xenium coordinate system
#                               (x_min, y_min, x_max, y_max)

