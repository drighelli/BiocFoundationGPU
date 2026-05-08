library(basilisk)

test_that("get basilisk environment", {
  obtainEnvironmentPath(.scgpt)
  obtainEnvironmentPath(.novae)
  obtainEnvironmentPath(.nimbus)
})