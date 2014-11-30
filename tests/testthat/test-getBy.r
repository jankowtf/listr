##------------------------------------------------------------------------------
context("getBy/list")
##------------------------------------------------------------------------------

test_that("getBy/list/named", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3)
  )
  getStructure(input)
  expect_identical(res <- getBy(input, value = "x1", field = "path"), input[1])
  expect_identical(res <- getBy(input, value = "1", field = "path"), list())
  expect_identical(res <- getBy(input, value = "1", field = "path", field_2 = "ppath"),
    list("1" = input[[1]]))
  
})