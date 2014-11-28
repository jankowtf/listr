##------------------------------------------------------------------------------
context("getByLevel/list")
##------------------------------------------------------------------------------

test_that("getByLevel/list/level = 1", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3),
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
  expect_is(res <- getByLevel(input, level = 1), "list")
  expect_identical(res, input)
  
  expect_is(res <- getByLevel(input, level = 1, parent = TRUE), "list")
  
})

test_that("getByLevel/list/level = 2", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3),
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
  expect_is(res <- getByLevel(input, level = 2), "list")
  expect_is(res <- getByLevel(input, level = 2, parent = TRUE), "list")
  
})

test_that("getByLevel/list/level = 3", {
  
  input <- list(
    x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
    x2 = list(x21 = "x21"),
    x3 = list("x31"),
    x4 = "x4",
    x5 = list(1:3),
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
  expect_is(res <- getByLevel(input, level = 3), "list")
  expect_is(res <- getByLevel(input, level = 3, parent = TRUE), "list")
#   getStructure(input)
  
})

test_that("getByLevel/list/invalid", {
  
  input <- list(a = 1)
  expect_identical(getByLevel(input, level = 2), list())
  expect_warning(getByLevel(input, level = 2, strict = 1))
  expect_error(getByLevel(input, level = 2, strict = 2))
  
})