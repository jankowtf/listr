#' @title
#' Class: RawObjectStructure.S3
#'
#' @description
#' Class to represent raw object structures (S3).
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{RawObjectStructure.S3}. Mainly intended for rapid prototyping 
#'    purposes
#' @param struc Constructor argument. See field \code{.struc}.
#'    
#' @field .struc \code{\link{data.frame}}. Object structure.
#' @return Instance of class \code{RawObjectStructure.S3}.
#' @example inst/examples/RawObjectStructure.S3.r
#' @seealso \code{
#'   	\link[listr]{getRawStructure}
#' }
#' @template author
#' @template references
#' @export
RawObjectStructure.S3 <- function(
  .x,
  struc = data.frame()
  
) {
  
  if (!missing(.x)) {
    class(.x) <- c("RawObjectStructure.S3", class(.x))
    out <- .x
  } else {
    out <- structure(
      list(.struc = struc),
      class = c("RawObjectStructure.S3", "list")
    )
  }
  return(out)
  
}
