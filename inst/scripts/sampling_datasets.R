library(OSTA.data)
library(SpatialExperimentIO)
library(SpatialExperiment)
library(VisiumIO)
library(SpaceTrooper)

# stored data are in a Google Drive folder, you can download them from there:
# https://drive.google.com/drive/folders/1BWWS4ThYFGXKwAGhmK_TurWVW-vs_8xU?usp=sharing
path <- "~/Downloads/HackathonFoundationExData"

### TODO: select cells based on a patch of 50x50 cells.


library(SpatialExperiment)

subset_spe_knn <- function(spe, center_idx, tot, x_col=1, y_col=2) {
    coords <- spatialCoords(spe)
    x <- coords[, x_col]
    y <- coords[, y_col]

    x0 <- x[center_idx]
    y0 <- y[center_idx]

    d2 <- (x - x0)^2 + (y - y0)^2
    idx <- order(d2)[seq_len(tot)]

    spe[, idx, drop=FALSE]
}

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
    images="hires",
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
(spe <- readCosmxSPE(td))

txsamp <- sample(dim(spe)[1],100)
spe1 <- subset_spe_knn(spe, center_idx=100, tot=100)
plotCentroids(spe1)
plotCellsFovs(spe1)
# cellsamp <- sample(dim(spe)[2],100)
# spe1 <- spe[txsamp, cellsamp]

saveRDS(spe1, file=file.path(path, "CosMx1k_MouseBrain1_100tx_100cl.rds"))

speprot <- readCosmxProteinSPE("~/Downloads/CosMx_data/S0_prot")
plotCellsFovs(speprot)

speprot <- readCosmxProteinSPE("~/Downloads/1102527")
)
