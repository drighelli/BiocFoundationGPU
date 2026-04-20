library(OSTA.data)
library(SpatialExperimentIO)
library(SpatialExperiment)
library(VisiumIO)

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
path <- "~/Downloads/HackathonFoundationExData"
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

