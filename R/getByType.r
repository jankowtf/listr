#' @title
#' Get By Type (generic)
#'
#' @description 
#' Retrieves actual values based on \code{type}.
#'   	
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param type \code{\link{numeric}} or \code{\link{integer}}.
#'    \itemize{
#'      \item{1: } {top-level branch values}
#'      \item{1: } {intermediate-level branch values}
#'      \item{3: } {leaf values}
#'    }
#' @template threedots
#' @example inst/examples/getByType.r
#' @seealso \code{
#'   	\link[listr]{getByType-list-method},
#'     \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getByType",
  signature = c(
    "input"
  ),
  def = function(
    input,
    type = c(1, 2, 3),
    ...
  ) {
    standardGeneric("getByType")       
  }
)

#' @title
#' Get By Type (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getByType}}
#'      
#' @inheritParams getByType
#' @param input \code{\link{list}}.
#' @return \code{\link{list}}. 
#' @example inst/examples/getByType.r
#' @seealso \code{
#'    \link[listr]{getByType},
#'    \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @aliases getByType-list-method
#' @export
setMethod(
  f = "getByType", 
  signature = signature(
    input = "list"
  ), 
  definition = function(
    input,
    type,
    ...
  ) {
    
  ## Argument checks //
  type <- as.numeric(match.arg(as.character(type), 
    as.character(c(1:3))))   
    
  struc <- getStructure(input = input, extended = TRUE)
  expr <- parse(text = paste0("input", struc[which(struc$type == type), "index"]))
  nms <- struc[which(struc$type == type), "name"]
  nms[is.na(nms)] <- ""
  envir <- environment()
  structure(lapply(expr, eval, envir = envir), names = nms)
    
  }
)

