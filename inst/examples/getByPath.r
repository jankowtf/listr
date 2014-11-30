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

## Name-based path //
getByPath(input, value = "x1")

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

}
