#' @title
#' Get By Level (generic)
#'
#' @description 
#' Retrieves actual values based on their \code{level} index.
#'   	
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param level \code{\link{numeric}} or \code{\link{integer}}.
#'    Level index as returned by \link[listr]{getStructure}.
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
    level = c(1, 2, 3),
    parent = FALSE,
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
    level,
    parent,
    strict,
    ...
  ) {
        
  ## Argument checks //
  strict <- as.numeric(match.arg(as.character(strict), 
    as.character(c(0, 1, 2))))     
    
  struc <- getStructure(input = input, extended = TRUE)
  if (!all(level %in% struc$level)) {
    out <- if (strict == 0) {
      list()
    } else if (strict == 1) {
      conditionr::signalCondition(
        condition = "InvalidLevel",
        msg = c(
          Reason = "invalid level",
          Level = level
        ),
        ns = "listr",
        type = "warning"
      ) 
      list()
    } else if (strict == 2) {
      conditionr::signalCondition(
        condition = "InvalidLevel",
        msg = c(
          Reason = "invalid level",
          Level = level
        ),
        ns = "listr",
        type = "error"
      ) 
    }
    return(out)
  }
  
  index <- if (!parent) "index" else "pindex"
  expr <- parse(text = paste0("input", struc[which(struc$level == level), index]))
  nms <- struc[which(struc$level == level), "name"]
  nms[is.na(nms)] <- ""
  envir <- environment()
  structure(lapply(expr, eval, envir = envir), names = nms)
    
  }
)

