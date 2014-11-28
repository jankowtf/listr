##------------------------------------------------------------------------------
context("getByName/list")
##------------------------------------------------------------------------------

test_that("getByName/list", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3)
  )
  expect_identical(res <- getByName(input, name = "x1"), input[1])
  expect_identical(res <- getByName(input, name = "x11"), input$x1[1])
  expect_identical(res <- getByName(input, name = "x111"), input$x1$x11[1])
  
})

test_that("getByName/list/multiple", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3)
  )
  expect_identical(res <- getByName(input, name = c("x1", "x11")), 
    c(input[1], input$x1[1]))
  
})

test_that("getByName/list/invalid", {
  
  input <- list(1)
  expect_identical(getByName(input, name = "x1111"), list())
  expect_warning(getByName(input, name = "x1111", strict = 1))
  expect_error(getByName(input, name = "x1111", strict = 2))
  
})
