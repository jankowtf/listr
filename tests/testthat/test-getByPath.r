##------------------------------------------------------------------------------
context("getByPath/list")
##------------------------------------------------------------------------------

test_that("getByPath/list/named", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3)
  )
  getStructure(input)
  expect_identical(res <- getByPath(input, value = "x1"), input[1])
  expect_identical(res <- getByPath(input, value = "x1/x11"), 
    list("x1/x11" = input$x1[[1]]))
  expect_identical(res <- getByPath(input, value = "x1/x11", resolve = TRUE), 
    input$x1[1])
  expect_identical(res <- getByPath(input, value = "x1/x11/x111"), 
    list("x1/x11/x111" = input$x1$x11[[1]]))
  expect_identical(res <- getByPath(input, value = "x1/x11/x111", resolve = TRUE), 
    input$x1$x11[1])
  
})

test_that("getByPath/list/unnamed", {
  
  input <- list(
    list(list(1, 2), list(3, 4)),
    list(1:3),
    "char 1",
    "char 2",
    letters[1:3],
    c(1,3,5),
    TRUE,
    new.env(),
    data.frame(x = 1:3, y = 1:3)
  )
  expect_identical(res <- getByPath(input, value = "1"), 
    list("1" = input[[1]]))
  expect_identical(res <- getByPath(input, value = "1", resolve = TRUE), 
    structure(input[1], names = ""))
  expect_identical(res <- getByPath(input, value = "1/1"), 
    list("1/1" = input[[1]][[1]]))
  expect_identical(res <- getByPath(input, value = "1/1", resolve = TRUE), 
    structure(input[[1]][1], names = ""))
  expect_identical(res <- getByPath(input, value = "1/1/2"), 
    list("1/1/2" = input[[1]][[1]][[2]]))
  expect_identical(res <- getByPath(input, value = "1/1/2", resolve = TRUE), 
    structure(input[[1]][[1]][2], names = ""))
  
})

test_that("getByPath/list/mixed", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    list(list(1, 2), list(3, 4))
  )
  expect_identical(res <- getByPath(input, value = "1"), 
    list("1" = input[[1]]))
  expect_identical(res <- getByPath(input, value = "1", resolve = TRUE), 
    input[1])
  expect_identical(res <- getByPath(input, value = "1/1"), 
    list("1/1" = input[[1]][[1]]))
  expect_identical(res <- getByPath(input, value = "1/1", resolve = TRUE), 
    input[[1]][1])
  expect_identical(res <- getByPath(input, value = "1/1/2"), 
    list("1/1/2" = input[[1]][[1]][[2]]))
  expect_identical(res <- getByPath(input, value = "1/1/2", resolve = TRUE), 
    input[[1]][[1]][2])
  
  expect_identical(res <- getByPath(input, value = "2"), 
    list("2" = input[[2]]))
  expect_identical(res <- getByPath(input, value = "2", resolve = TRUE), 
    structure(input[2], names = ""))
  expect_identical(res <- getByPath(input, value = "2/1"), 
    list("2/1" = input[[2]][[1]]))
  expect_identical(res <- getByPath(input, value = "2/1", resolve = TRUE), 
    structure(input[[2]][1], names = ""))
  expect_identical(res <- getByPath(input, value = "2/1/2"), 
    list("2/1/2" = input[[2]][[1]][[2]]))
  expect_identical(res <- getByPath(input, value = "2/1/2", resolve = TRUE), 
    structure(input[[2]][[1]][2], names = ""))
  
})

test_that("getByPath/list/multiple", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3)
  )
  expect_identical(res <- getByPath(input, value = c("x1", "x1/x11")), 
    list("x1" = input[[1]], "x1/x11" = input$x1[[1]]))
  expect_identical(res <- getByPath(input, value = c("x1", "x1/x11"), 
    resolve = TRUE), 
    list("x1" = input[[1]], "x11" = input$x1[[1]]))
  
})

test_that("getByPath/list/invalid", {
  
  input <- list(1)
  expect_identical(getByPath(input, value = "x1111"), list())
  expect_warning(getByPath(input, value = "x1111", strict = 1))
  expect_error(getByPath(input, value = "x1111", strict = 2))
  
  input <- list(1)
  expect_identical(getByPath(input, value = "x1/x1111"), list())
  expect_warning(getByPath(input, value = "x1/x1111", strict = 1))
  expect_error(getByPath(input, value = "x1/x1111", strict = 2))
  
})
