\dontrun{

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

## Inspect structure //
(struc <- getStructure(input))

## By name //
getBy(input, value = "x1", field = "name")

## By path //
getBy(input, value = "x1/x11", field = "path")

## By level //
getBy(input, value = "3", field = "level")
## --> all values that are on level 3

## By type //
getBy(input, value = "1", field = "type")
## --> top-level branches
getBy(input, value = "2", field = "type")
## --> intermediate-level branches
getBy(input, value = "3", field = "type")
## --> leafs

}
