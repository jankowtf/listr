\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
RawObjectStructure.S3(data.frame())  
RawObjectStructure.S3("example of other input")  

## Formal use (explicitly using field constructor arguments) //
RawObjectStructure.S3()
RawObjectStructure.S3(struc = getRawStructure(list(a = 1, b = 2)))

## Recommended: inlcude namespace //
listr::RawObjectStructure.S3(struc = getRawStructure(list(a = 1, b = 2)))

}
