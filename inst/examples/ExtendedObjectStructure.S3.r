\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
ExtendedObjectStructure.S3(data.frame())  
ExtendedObjectStructure.S3("example of other input")  

## Formal use (explicitly using field constructor arguments) //
ExtendedObjectStructure.S3()
ExtendedObjectStructure.S3(struc = getStructure(list(a = 1, b = 2)))

## Recommended: inlcude namespace //
listr::ExtendedObjectStructure.S3(
  struc = getStructure(list(a = 1, b = 2))
)

}
