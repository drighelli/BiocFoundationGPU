dir<-"/Users/amanuky/Dropbox/Research/MDC/Events/2026/Venice BioC Hackathon/tracks/FM/data/scgpt/"
h5ad_file <- file.path(dir,"batch_covid_subsampled_test_100cells.h5ad")
model_dir <- file.path(dir)

# h5ad_file <- google drive https://drive.google.com/file/d/1Do7CXaaSTwEySGWHMKAkpN5G_g-OY8y2/view?usp=drive_link
# model_dir <- google drive https://drive.google.com/drive/folders/1oWh_-ZRdhtoGQ2Fw24HP41FgLoomVo-y
result <- Run_scGPT(
    h5ad_file = h5ad_file,
    model_dir = model_dir,
    gene_col = "gene_name"
)