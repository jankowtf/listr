context("ObjectStructure.S3")
test_that("ObjectStructure.S3", {

  expect_is(ObjectStructure.S3(), "ObjectStructure.S3")
  expect_is(ObjectStructure.S3(struc = data.frame()), "ObjectStructure.S3")
  expect_is(res <- ObjectStructure.S3(data.frame()), "ObjectStructure.S3")
  expect_is(ObjectStructure.S3(.x = data.frame()), "ObjectStructure.S3")
  
})

