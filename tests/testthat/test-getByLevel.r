##------------------------------------------------------------------------------
context("getByLevel/list")
##------------------------------------------------------------------------------

test_that("getByLevel/list/value = 1", {
  
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
  expect_is(res <- getByLevel(input, value = 1), "list")
  expect_identical(res, structure(input, names = rep("1", length(input))))
  expect_is(res <- getByLevel(input, value = 1, resolve = TRUE), "list")
  expect_identical(res, input)
  
  expect_is(res <- getByLevel(input, value = 1, outer = TRUE), "list")
  
})

test_that("getByLevel/list/value = 2", {
  
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
  expect_is(res <- getByLevel(input, value = 2), "list")
  expect_is(res <- getByLevel(input, value = 2, outer = TRUE), "list")
  
})

test_that("getByLevel/list/value = 3", {
  
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
  expect_is(res <- getByLevel(input, value = 3), "list")
  expect_is(res <- getByLevel(input, value = 3, outer = TRUE), "list")
#   getStructure(input)
  
})

test_that("getByLevel/list/invalid", {
  
  input <- list(a = 1)
  expect_identical(getByLevel(input, value = 2), list())
  expect_warning(getByLevel(input, value = 2, strict = 1))
  expect_error(getByLevel(input, value = 2, strict = 2))
  
})