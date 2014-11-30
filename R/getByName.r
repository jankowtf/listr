#' @title
#' Get By Name (generic)
#'
#' @description 
#' Retrieves actual values based on their \code{name}.
#'     
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param value \code{\link{character}}.
#'    Name as found in return value of \link[listr]{getStructure}.
#' @param outer \code{\link{logical}}.
#'    \code{TRUE}: use \code{oindex} instead of \code{index} to retrieve the 
#'      outer element values (i.e., outer list structure is preserved);
#'    \code{FALSE}: use \code{index} to retrieve the inner element values
#'      (i.e. outer list structure is not preserved).
#' @param resolve \code{\link{logical}}.
#'    \code{TRUE}: resolve path to basename component as names for return value;
#'    \code{FALSE}: use path as names for return value. 
#' @param strict \code{\link{numeric}}.
#'    \itemize{
#'      \item{\code{0}: } {ignore without warning}
#'      \item{\code{1}: } {ignore with Warning}
#'      \item{\code{2}: } {stop with error}
#'    }
#' @template threedots
#' @example inst/examples/getByName.r
#' @seealso \code{
#'   	\link[listr]{getByName-list-method},
#'     \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getByName",
  signature = c(
    "input"
  ),
  def = function(
    input,
    value,
    outer = FALSE,
    resolve = FALSE,
    strict = c(0, 1, 2),
    ...
  ) {
    standardGeneric("getByName")       
  }
)

#' @title
#' Get By name (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getByName}}
#'      
#' @inheritParams getByName
#' @param input \code{\link{list}}.
#' @return \code{\link{list}}. 
#' @example inst/examples/getByName.r
#' @seealso \code{
#'    \link[listr]{getByName},
#'    \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @aliases getByName-list-method
#' @export
setMethod(
  f = "getByName", 
  signature = signature(
    input = "list"
  ), 
  definition = function(
    input,
    value,
    outer,
    resolve,
    strict,
    ...
  ) {
    
  getBy(
    input = input,
    value = value,
    field = "name",
    outer = outer,
    resolve = resolve,
    strict = strict,  
    ...
  )
    
  }
)

