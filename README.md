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
