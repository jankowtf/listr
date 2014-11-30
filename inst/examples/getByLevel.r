\dontrun{

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

## Inspect structure //
(struc <- getStructure(input))

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

}
