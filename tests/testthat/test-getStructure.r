##------------------------------------------------------------------------------
context("getStructure/list")
##------------------------------------------------------------------------------

test_that("getStructure/list/regular", {
  
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
  expect_is(res <- getStructure(input, extended = FALSE), "ObjectStructure.S3")
  expect_true(all(names(res) %in% c("X1", "X2", "X3", "name", "class", "str")))
  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) == 32)
  
})

test_that("getStructure/list/extended", {
  
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
  expect_is(res <- getStructure(input), "ExtendedObjectStructure.S3")
  expect_true(all(names(res) %in% 
    c("X1", "X2", "X3", "level", "type", "index", "pindex", 
      "name", "class", "str")))
  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) == 32)
  
})

##------------------------------------------------------------------------------
context("getStructure/RawObjectStructure.S3")
##------------------------------------------------------------------------------

test_that("getStructure/RawObjectStructure.S3", {
  
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
  input <- getRawStructure(input)
  expect_is(res <- getStructure(input), "ExtendedObjectStructure.S3")
  expect_true(all(names(res) %in% 
    c("X1", "X2", "X3", "level", "type", "index", "pindex", 
      "name", "class", "str")))
  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) == 32)
  
})