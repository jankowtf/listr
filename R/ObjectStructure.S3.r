#' @title
#' Class: ObjectStructure.S3
#'
#' @description
#' Class to represent object structures (S3).
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{ObjectStructure.S3}. Mainly intended for rapid prototyping 
#'    purposes
#' @param struc Constructor argument. See field \code{.struc}.
#'    
#' @field .struc \code{\link{data.frame}}. Object structure.
#' @return Instance of class \code{ObjectStructure.S3}.
#' @example inst/examples/ObjectStructure.S3.r
#' @seealso \code{
#'   	\link[listr]{getStructure},
#'     \link[listr]{getRawStructure},
#'     \link[listr]{RawObjectStructure.S3}
#' }
#' @template author
#' @template references
#' @export
ObjectStructure.S3 <- function(
  .x,
  struc = data.frame()
) {
  
  if (!missing(.x)) {
    class(.x) <- c("ObjectStructure.S3", class(.x))
    out <- .x
  } else {
    out <- structure(
      list(.struc = struc),
      class = c("ObjectStructure.S3", "list")
    )
  }
  return(out)
  
}
