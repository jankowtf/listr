\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
ObjectStructure.S3(data.frame())  
ObjectStructure.S3("example of other input")  

## Formal use (explicitly using field constructor arguments) //
ObjectStructure.S3()
ObjectStructure.S3(struc = getStructure(list(a = 1, b = 2), extended = FALSE))

## Recommended: inlcude namespace //
listr::ObjectStructure.S3(
  struc = getStructure(list(a = 1, b = 2), extended = FALSE)
)

}
