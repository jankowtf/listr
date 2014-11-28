#' @title
#' Class: ExtendedObjectStructure.S3
#'
#' @description
#' Class to represent extended object structures (S3).
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{ExtendedObjectStructure.S3}. Mainly intended for rapid prototyping 
#'    purposes
#' @param struc Constructor argument. See field \code{.struc}.
#'    
#' @field .struc \code{\link{data.frame}}. Object structure.
#' @return Instance of class \code{ExtendedObjectStructure.S3}.
#' @example inst/examples/ExtendedObjectStructure.S3.r
#' @seealso \code{
#'     \link[listr]{extendStructure},
#'     \link[listr]{getRawStructure},
#'     \link[listr]{getStructure},
#'     \link[listr]{ObjectStructure.S3}
#' }
#' @template author
#' @template references
#' @export
ExtendedObjectStructure.S3 <- function(
  .x,
  struc = data.frame()
) {
  
  if (!missing(.x)) {
    class(.x) <- c("ExtendedObjectStructure.S3", class(.x))
    out <- .x
  } else {
    out <- structure(
      list(.struc = struc),
      class = c("ExtendedObjectStructure.S3", "list")
    )
  }
  return(out)
  
}
