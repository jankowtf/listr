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
  x1 = list(x11 = list(x111 = list(x1111 = 1, x1112 = 2), x112 = 1), 
    x12 = list(x121 = 1, x122 = 1)),
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
# getStructure(input)
#    X1 X2 X3 X4 type                index             oindex              path   ppath level  name       class dim
# 1   1 NA NA NA    1                [[1]]                [1]                x1       1     1    x1        list   2
# 2   1  1 NA NA    2           [[1]][[1]]           [[1]][1]            x1/x11     1/1     2   x11        list   2
# 3   1  1  1 NA    2      [[1]][[1]][[1]]      [[1]][[1]][1]       x1/x11/x111   1/1/1     3  x111        list   2
# 4   1  1  1  1    2 [[1]][[1]][[1]][[1]] [[1]][[1]][[1]][1] x1/x11/x111/x1111 1/1/1/1     4 x1111     numeric   1
# 5   1  1  1  2    2 [[1]][[1]][[1]][[2]] [[1]][[1]][[1]][2] x1/x11/x111/x1112 1/1/1/2     4 x1112     numeric   1
# 6   1  1  2 NA    2      [[1]][[1]][[2]]      [[1]][[1]][2]       x1/x11/x112   1/1/2     3  x112     numeric   1
# 7   1  2 NA NA    2           [[1]][[2]]           [[1]][2]            x1/x12     1/2     2   x12        list   2
# 8   1  2  1 NA    2      [[1]][[2]][[1]]      [[1]][[2]][1]       x1/x12/x111   1/2/1     3  x121     numeric   1
# 9   1  2  2 NA    2      [[1]][[2]][[2]]      [[1]][[2]][2]       x1/x12/x112   1/2/2     3  x122     numeric   1
# 10  2 NA NA NA    1                [[2]]                [2]                x2       2     1    x2        list   1
# 11  2  1 NA NA    2           [[2]][[1]]           [[2]][1]            x2/x21     2/1     2   x21   character   1
# 12  3 NA NA NA    1                [[3]]                [3]                x3       3     1    x3        list   1
# 13  3  1 NA NA    2           [[3]][[1]]           [[3]][1]              x3/1     3/1     2  <NA>   character   1
# 14  4 NA NA NA    3                [[4]]                [4]                x4       4     1    x4   character   1
# 15  5 NA NA NA    1                [[5]]                [5]                x5       5     1    x5        list   1
# 16  5  1 NA NA    2           [[5]][[1]]           [[5]][1]              x5/1     5/1     2  <NA>     integer   3
# 17  6 NA NA NA    1                [[6]]                [6]                 6       6     1  <NA>        list   2
# 18  6  1 NA NA    2           [[6]][[1]]           [[6]][1]               6/1     6/1     2  <NA>        list   2
# 19  6  1  1 NA    2      [[6]][[1]][[1]]      [[6]][[1]][1]             6/1/1   6/1/1     3  <NA>     numeric   1
# 20  6  1  2 NA    2      [[6]][[1]][[2]]      [[6]][[1]][2]             6/1/2   6/1/2     3  <NA>     numeric   1
# 21  6  2 NA NA    2           [[6]][[2]]           [[6]][2]               6/2     6/2     2  <NA>        list   2
# 22  6  2  1 NA    2      [[6]][[2]][[1]]      [[6]][[2]][1]             6/2/1   6/2/1     3  <NA>     numeric   1
# 23  6  2  2 NA    2      [[6]][[2]][[2]]      [[6]][[2]][2]             6/2/2   6/2/2     3  <NA>     numeric   1
# 24  7 NA NA NA    1                [[7]]                [7]                 7       7     1  <NA>        list   1
# 25  7  1 NA NA    2           [[7]][[1]]           [[7]][1]               7/1     7/1     2  <NA>     integer   3
# 26  8 NA NA NA    3                [[8]]                [8]                 8       8     1  <NA>   character   1
# 27  9 NA NA NA    3                [[9]]                [9]                 9       9     1  <NA>   character   1
# 28 10 NA NA NA    3               [[10]]               [10]                10      10     1  <NA>   character   3
# 29 11 NA NA NA    3               [[11]]               [11]                11      11     1  <NA>     numeric   3
# 30 12 NA NA NA    3               [[12]]               [12]                12      12     1  <NA>     logical   1
# 31 13 NA NA NA    3               [[13]]               [13]                13      13     1  <NA> environment   0
# 32 14 NA NA NA    3               [[14]]               [14]                14      14     1  <NA>  data.frame 3 2
```

Get regular structure

```
getStructure(input, extended = FALSE)
```

## Get by type

```
## Type 1 (top-level branches) //
getByType(input, value = 1)

## Type 2 (intermediate-level branches) //
getByType(input, value = 2)

## Type 3 (leafs) //
getByType(input, value = 3)

## Condition handling //
getByType(input, value = 4)
try(getByType(input, value = 4, strict = 1))
try(getByType(input, value = 4, strict = 2))
```

## Get by level

```
getByLevel(input, value = 1)
getByLevel(input, value = 1, resolve = TRUE)

getByLevel(input, value = 2)
getByLevel(input, value = 2, resolve = TRUE)

getByLevel(input, value = 3)
getByLevel(input, value = 3, resolve = TRUE)

getByLevel(input, value = 4)
getByLevel(input, value = 4, resolve = TRUE)

## Condition handling //
getByLevel(input, value = 5)
try(getByLevel(input, value = 5, strict = 1))
try(getByLevel(input, value = 5, strict = 2))
```

## Get by name

```
getByName(input, value = "x1")

getByName(input, value = "x11")
getByName(input, value = "x21")

getByName(input, value = c("x11", "x21"))

## Condition handling //
getByName(input, value = "non-existing")
try(getByName(input, value = "non-existing", strict = 1))
try(getByName(input, value = "non-existing", strict = 2))

```

## Get by path

```
getByPath(input, value = "x1/x11")
getByPath(input, value = "x1/x11", resolve = TRUE)
getByPath(input, value = "x1/x11", resolve = TRUE, resolve_by = "ppath")

getByPath(input, value = "x2/x21")
getByPath(input, value = "x2/x21", resolve = TRUE)
getByPath(input, value = "x2/x21", resolve = TRUE, resolve_by = "index")

## Position-based path //
getByPath(input, value = "6/1")
getByPath(input, value = "6/1", resolve = TRUE)
getByPath(input, value = "6/1", resolve = TRUE, resolve_by = "ppath")

## Multiple //
getByPath(input, value = c("x1/x11", "x2/x21"))
getByPath(input, value = c("x1/x11", "x2/x21"), resolve = TRUE)
getByPath(input, value = c("x1/x11", "x2/x21"), resolve = TRUE, resolve_by = "ppath")

getByPath(input, value = c("x1/x11", "x2/x21", "6/1"))
getByPath(input, value = c("x1/x11", "x2/x21", "6/1"), resolve = TRUE)
getByPath(input, value = c("x1/x11", "x2/x21", "6/1"), resolve = TRUE, 
  resolve_by = "index")

## Condition handling //
getByPath(input, value = "x1/99")
try(getByPath(input, value = "x1/99", strict = 1))
try(getByPath(input, value = "x1/99", strict = 2))
```
