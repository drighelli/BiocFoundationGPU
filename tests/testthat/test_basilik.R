library(basilisk)

test_that("get basilisk environment", {
  obtainEnvironmentPath(.scgpt)
  # obtainEnvironmentPath(.scfoundation) # DOES NOT WORK NOW
  obtainEnvironmentPath(.novae)
})