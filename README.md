listr
======

Extended list functionality

## Installation

```
require("devtools")

## Package `conditionr` //
devtools::install_github("Rappster/conditionr")

## Package `reactr` and dependencies //
devtools::install_github("Rappster/yamlr")
devtools::install_github("Rappster/typr")
devtools::install_github("Rappster/reactr")

## Actual package //
devtools::install_github("Rappster/listr")
require("listr")
```
## Purpose

The package provides extended functionality for working with lists

## Vignettes

None so far

----------

## Structure

Example list

```
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
```

Get extended structure

```
getStructure(input)
#    X1 X2 X3 type           index        oindex        path ppath level name       class dim
# 1   1 NA NA    1           [[1]]           [1]          x1     1     1   x1        list   2
# 2   1  1 NA    2      [[1]][[1]]      [[1]][1]      x1/x11   1/1     2  x11        list   2
# 3   1  1  1    2 [[1]][[1]][[1]] [[1]][[1]][1] x1/x11/x111 1/1/1     3 x111     numeric   1
# 4   1  1  2    2 [[1]][[1]][[2]] [[1]][[1]][2] x1/x11/x112 1/1/2     3 x112     numeric   1
# 5   1  2 NA    2      [[1]][[2]]      [[1]][2]      x1/x12   1/2     2  x12        list   2
# 6   1  2  1    2 [[1]][[2]][[1]] [[1]][[2]][1] x1/x12/x111 1/2/1     3 x121     numeric   1
# 7   1  2  2    2 [[1]][[2]][[2]] [[1]][[2]][2] x1/x12/x112 1/2/2     3 x122     numeric   1
# 8   2 NA NA    1           [[2]]           [2]          x2     2     1   x2        list   1
# 9   2  1 NA    2      [[2]][[1]]      [[2]][1]      x2/x21   2/1     2  x21   character   1
# 10  3 NA NA    1           [[3]]           [3]          x3     3     1   x3        list   1
# 11  3  1 NA    2      [[3]][[1]]      [[3]][1]        x3/1   3/1     2 <NA>   character   1
# 12  4 NA NA    3           [[4]]           [4]          x4     4     1   x4   character   1
# 13  5 NA NA    1           [[5]]           [5]          x5     5     1   x5        list   1
# 14  5  1 NA    2      [[5]][[1]]      [[5]][1]        x5/1   5/1     2 <NA>     integer   3
# 15  6 NA NA    1           [[6]]           [6]           6     6     1 <NA>        list   2
# 16  6  1 NA    2      [[6]][[1]]      [[6]][1]         6/1   6/1     2 <NA>        list   2
# 17  6  1  1    2 [[6]][[1]][[1]] [[6]][[1]][1]       6/1/1 6/1/1     3 <NA>     numeric   1
# 18  6  1  2    2 [[6]][[1]][[2]] [[6]][[1]][2]       6/1/2 6/1/2     3 <NA>     numeric   1
# 19  6  2 NA    2      [[6]][[2]]      [[6]][2]         6/2   6/2     2 <NA>        list   2
# 20  6  2  1    2 [[6]][[2]][[1]] [[6]][[2]][1]       6/2/1 6/2/1     3 <NA>     numeric   1
# 21  6  2  2    2 [[6]][[2]][[2]] [[6]][[2]][2]       6/2/2 6/2/2     3 <NA>     numeric   1
# 22  7 NA NA    1           [[7]]           [7]           7     7     1 <NA>        list   1
# 23  7  1 NA    2      [[7]][[1]]      [[7]][1]         7/1   7/1     2 <NA>     integer   3
# 24  8 NA NA    3           [[8]]           [8]           8     8     1 <NA>   character   1
# 25  9 NA NA    3           [[9]]           [9]           9     9     1 <NA>   character   1
# 26 10 NA NA    3          [[10]]          [10]          10    10     1 <NA>   character   3
# 27 11 NA NA    3          [[11]]          [11]          11    11     1 <NA>     numeric   3
# 28 12 NA NA    3          [[12]]          [12]          12    12     1 <NA>     logical   1
# 29 13 NA NA    3          [[13]]          [13]          13    13     1 <NA> environment   0
# 30 14 NA NA    3          [[14]]          [14]          14    14     1 <NA>  data.frame 3 2
```

Get regular structure

```
getStructure(input, extended = FALSE)
```

## Get by type

```
getByType(input, type = 1)
getByType(input, type = 2)
getByType(input, type = 3)
```

## Get by level

```
getByLevel(input, level = 1)
getByLevel(input, level = 2)
getByLevel(input, level = 3)
getByLevel(input, level = 4)
try(getByLevel(input, level = 4, strict = 1))
try(getByLevel(input, level = 4, strict = 2))
```

## Get by name

```
getByName(input, name = "x1")
getByName(input, name = "x11")
getByName(input, name = "x111")
getByName(input, name = c("x1", "x112"))
getByName(input, name = "x10")
try(getByName(input, name = "x10", strict = 1))
try(getByName(input, name = "x10", strict = 2))

```

## Get by path

```
getByPath(input, value = "1")
getByPath(input, value = "1", resolve = TRUE)

getByPath(input, value = "1/1")
getByPath(input, value = "1/1", resolve = TRUE)

getByPath(input, value = "1/1/2")
getByPath(input, value = "1/1/2", resolve = TRUE)

getByPath(input, value = c("1", "1/2"))
getByPath(input, value = c("1", "1/2"), resolve = TRUE)

getByPath(input, value = "1/99")
try(getByPath(input, value = "1/99", strict = 1))
try(getByPath(input, value = "1/99", strict = 2))

```
