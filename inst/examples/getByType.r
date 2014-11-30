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

}
