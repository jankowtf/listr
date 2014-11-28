context("RawObjectStructure.S3")
test_that("RawObjectStructure.S3", {

  expect_is(RawObjectStructure.S3(), "RawObjectStructure.S3")
  expect_is(RawObjectStructure.S3(struc = data.frame()), "RawObjectStructure.S3")
  expect_is(res <- RawObjectStructure.S3(data.frame()), "RawObjectStructure.S3")
  expect_is(RawObjectStructure.S3(.x = data.frame()), "RawObjectStructure.S3")
  
  }
)

