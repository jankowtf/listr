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
x=input
foo <- function(x) {
  list(level = length(x), class = class(x))
}
str(x)
rapply(input, foo, how = "list")

bar <- function(x, level = 0) {
  level <- level + 1
  out <- lapply(seq(along = x), function(el) {
    name <- names(x[el])
    value <- x[[el]]
    cls <- class(value)
    .dim <- if (cls %in% c("data.frame", "matrix")) {
      paste(dim(value), collapse = " ")
    } else {
      length(value)
    }  
    out <- data.frame(
      level = level,
      name = if (is.null(name) || name == "") NA else name,
      class = cls,
      dim = .dim,
      stringsAsFactors = FALSE
    )
    if (cls == "list") {
      deep <- bar(x = value, level = level)
      c(list(out), unlist(deep, recursive = FALSE))
    } else {
      list(out)
    }
  })  
}
# bar(x)
tmp <- bar(input[1:3])
tmp[[1]]
x=input
foobar <- function(x) {
  tmp <- do.call("rbind", unlist(bar(x = x), recursive = FALSE))
#   tmp$name[tmp$name == ""] <- NA
  subs <- tmp$level
  subs_2 <- lapply(1:subs[which.max(subs)], function(ii) {
    out <- subs == ii
    out[out] <- 1
    out
  })
  names(subs_2) <- 1:length(subs_2)
  data.frame(subs_2, tmp, stringsAsFactors = FALSE)
}
getRawStructure(input)
getStructure(input)
(struc <- foobar(input))


struc$name
getRawStructure(input)

scope = 10000
x=as.list(1:scope)
x <- input
res_1 <- system.time(struc <- capture.output(str(x, list.len=length(x))))
res_2 <- system.time(struc <- rapply(x, foo, how = "list"))
res_3 <- system.time(struc <- foobar(x))
res_1
res_2
res_3

require("microbenchmark")
res <- microbenchmark(
  "0" = str(x, list.len=length(x)),
  "1" = capture.output(str(x, list.len=length(x))),
  "2" = rapply(x, foo, how = "list"),
  "3" = foobar(x),
  times = 20,
  unit = "s"
)
res
microbenchmark(1:10000, unit = "s")
(6300.987577/10^5/10000) * 10^6
(5120/10^9/1000) * 10^6

X <- list(list(a = pi, b = list(c = 1:1)), d = "a test")
rapply(X, function(x) x, how = "replace")
rapply(X, sqrt, classes = "numeric", how = "replace")

system.time(capture.output(str(x)))
system.time(dump(str(x), file = ""))