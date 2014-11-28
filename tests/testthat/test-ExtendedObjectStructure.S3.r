context("ExtendedObjectStructure.S3")
test_that("ExtendedObjectStructure.S3", {

  expect_is(ExtendedObjectStructure.S3(), "ExtendedObjectStructure.S3")
  expect_is(ExtendedObjectStructure.S3(struc = data.frame()), "ExtendedObjectStructure.S3")
  expect_is(res <- ExtendedObjectStructure.S3(data.frame()), "ExtendedObjectStructure.S3")
  expect_is(ExtendedObjectStructure.S3(.x = data.frame()), "ExtendedObjectStructure.S3")
  
})

