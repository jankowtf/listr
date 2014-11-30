#' @title
#' Get By Level (generic)
#'
#' @description 
#' Retrieves actual values based on their \code{level}.
#'     
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param value \code{\link{character}}.
#'    Level as found in return value of \link[listr]{getStructure}.
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
#' @example inst/examples/getByLevel.r
#' @seealso \code{
#'   	\link[listr]{getByLevel-list-method},
#'     \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getByLevel",
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
    standardGeneric("getByLevel")       
  }
)

#' @title
#' Get By Level (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getByLevel}}
#'      
#' @inheritParams getByLevel
#' @param input \code{\link{list}}.
#' @return \code{\link{list}}. 
#' @example inst/examples/getByLevel.r
#' @seealso \code{
#'    \link[listr]{getByLevel},
#'    \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @aliases getByLevel-list-method
#' @export
setMethod(
  f = "getByLevel", 
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
        
#   ## Argument checks //
#   strict <- as.numeric(match.arg(as.character(strict), 
#     as.character(c(0, 1, 2))))     
#     
#   struc <- getStructure(input = input, extended = TRUE)
#   if (!all(level %in% struc$level)) {
#     out <- if (strict == 0) {
#       list()
#     } else if (strict == 1) {
#       conditionr::signalCondition(
#         condition = "InvalidLevel",
#         msg = c(
#           Reason = "invalid level",
#           Level = level
#         ),
#         ns = "listr",
#         type = "warning"
#       ) 
#       list()
#     } else if (strict == 2) {
#       conditionr::signalCondition(
#         condition = "InvalidLevel",
#         msg = c(
#           Reason = "invalid level",
#           Level = level
#         ),
#         ns = "listr",
#         type = "error"
#       ) 
#     }
#     return(out)
#   }
#   
#   index <- if (!parent) "index" else "pindex"
#   expr <- parse(text = paste0("input", struc[which(struc$level == level), index]))
#   nms <- struc[which(struc$level == level), "name"]
#   nms[is.na(nms)] <- ""
#   envir <- environment()
#   structure(lapply(expr, eval, envir = envir), names = nms)
  getBy(
    input = input,
    value = value,
    field = "level",
    outer = outer,
    resolve = resolve,
    strict = strict,  
    ...
  )
    
  }
)

