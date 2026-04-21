#' @importFrom basilisk BasiliskEnvironment
.scgpt <- BasiliskEnvironment(
  pkgname="BiocFoundationGPU", 
  envname="scgpt",
  packages=c("python==3.13.0"),
  pip= c("scgpt==0.2.4"))

#' @importFrom basilisk BasiliskEnvironment
.scfoundation <- BasiliskEnvironment(
  pkgname="BiocFoundationGPU", 
  envname="scfoundation",
  packages=c("python==3.7.1"),
  pip= c("scfoundation==0.0.1"))

#' @importFrom basilisk BasiliskEnvironment
.novae <- BasiliskEnvironment(
  pkgname="BiocFoundationGPU", 
  envname="novae",
  packages=c("python==3.13.0"),
  pip= c("novae==1.0.4"))