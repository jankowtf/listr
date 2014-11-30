##------------------------------------------------------------------------------
context("getRawStructure")
##------------------------------------------------------------------------------

test_that("getRawStructure", {
  
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
  expect_is(res <- getRawStructure(input), "RawObjectStructure.S3")
  expect_true(all(names(res) %in% c("X1", "X2", "X3", "level", "name", "class", "dim")))
  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) == 30)
  
})
