#' @title
#' Get By Path (generic)
#'
#' @description 
#' Retrieves actual values based on their \code{path}.
#'   	
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param value \code{\link{character}}.
#'    Path as found in return value of \link[listr]{getStructure}.
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
#' @example inst/examples/getByPath.r
#' @seealso \code{
#'   	\link[listr]{getByPath-list-method},
#'     \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getByPath",
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
    standardGeneric("getByPath")       
  }
)

#' @title
#' Get By Path (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getByPath}}
#'      
#' @inheritParams getByPath
#' @param input \code{\link{list}}.
#' @return \code{\link{list}}. 
#' @example inst/examples/getByPath.r
#' @seealso \code{
#'    \link[listr]{getByPath},
#'    \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @aliases getByPath-list-method
#' @export
setMethod(
  f = "getByPath", 
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
#   field <- "path"
#   if (!all(value %in% struc[[field]])) {
#     field <- "ppath"
#     if (!all(value %in% struc[[field]])) {
#       out <- if (strict == 0) {
#         list()
#       } else if (strict == 1) {
#         conditionr::signalCondition(
#           condition = "Invalid",
#           msg = c(
#             Reason = "invalid retrieval value",
#             Value = value,
#             Available = paste(struc[[field]], collapse = ", ")
#           ),
#           ns = "listr",
#           type = "warning"
#         ) 
#         list()
#       } else if (strict == 2) {
#         conditionr::signalCondition(
#           condition = "InvalidName",
#           msg = c(
#             Reason = "invalid retrieval value",
#             Value = value,
#             Available = paste(struc[[field]], collapse = ", ")
#           ),
#           ns = "listr",
#           type = "error"
#         ) 
#       }
#       return(out)
#     }
#   }
#   
#   index <- if (!outer) "index" else "oindex"
#   expr <- parse(text = paste0("input", 
#     struc[which(struc[[field]] == value), index]))
#   nms <- if (!resolve) {
#     struc[which(struc[[field]] == value), field]
#   } else {
#     struc[which(struc[[field]] == value), "name"]
#   }
#   nms[is.na(nms)] <- ""
#   envir <- environment()
#   structure(lapply(expr, eval, envir = envir), names = nms)
    getBy(
      input = input,
      value = value,
      field = "path", 
      field_2 = "ppath",
      outer = outer,
      resolve = resolve,
      strict = strict,  
      ...
    )
    
  }
)

