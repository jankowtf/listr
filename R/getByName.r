#' @title
#' Get By Name (generic)
#'
#' @description 
#' Retrieves actual values based on their \code{name} index.
#'   	
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param name \code{\link{numeric}} or \code{\link{integer}}.
#'    Name index as returned by \link[listr]{getStructure}.
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
    name,
    parent = FALSE,
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
    name,
    parent,
    strict,
    ...
  ) {
    
  ## Argument checks //
  strict <- as.numeric(match.arg(as.character(strict), 
    as.character(c(0, 1, 2))))       
        
  struc <- getStructure(input = input, extended = TRUE)
  if (!all(name %in% struc$name)) {
    out <- if (strict == 0) {
      list()
    } else if (strict == 1) {
      conditionr::signalCondition(
        condition = "InvalidName",
        msg = c(
          Reason = "invalid name",
          Name = name
        ),
        ns = "listr",
        type = "warning"
      ) 
      list()
    } else if (strict == 2) {
      conditionr::signalCondition(
        condition = "InvalidName",
        msg = c(
          Reason = "invalid name",
          Name = name
        ),
        ns = "listr",
        type = "error"
      ) 
    }
    return(out)
  }
  
  index <- if (!parent) "index" else "pindex"
  expr <- parse(text = paste0("input", struc[which(struc$name == name), index]))
  nms <- struc[which(struc$name == name), "name"]
  nms[is.na(nms)] <- ""
  envir <- environment()
  structure(lapply(expr, eval, envir = envir), names = nms)
    
  }
)

