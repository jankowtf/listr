#' @title
#' Get By (generic)
#'
#' @description 
#' Retrieves actual values based on \code{value} associated to \code{field}.
#'   	
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @param value \code{\link{character}}.
#'    Value of \code{field} as found in return value of 
#'    \link[listr]{getStructure}.
#' @param field \code{\link{character}}.
#'    Field/column name as found in return value of 
#'    \link[listr]{getStructure}.
#' @param field_2 \code{\link{character}}.
#'    Field/column name as found in return value of 
#'    \link[listr]{getStructure} used as fallback.
#' @param resolve_by \code{\link{character}}.
#'    Field/column for name substitution if \code{resolve = TRUE}.
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
#' @example inst/examples/getBy.r
#' @seealso \code{
#'   	\link[listr]{getBy-list-method},
#'     \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getBy",
  signature = c(
    "input"
  ),
  def = function(
    input,
    value,
    field,
    field_2 = character(),
    resolve_by = "name",
    outer = FALSE,
    resolve = FALSE,
    strict = c(0, 1, 2),
    ...
  ) {
    standardGeneric("getBy")       
  }
)

#' @title
#' Get By (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getBy}}
#'      
#' @inheritParams getBy
#' @param input \code{\link{list}}.
#' @return \code{\link{list}}. 
#' @example inst/examples/getBy.r
#' @seealso \code{
#'    \link[listr]{getBy},
#'    \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @aliases getBy-list-method
#' @import conditionr
#' @export
setMethod(
  f = "getBy", 
  signature = signature(
    input = "list"
  ), 
  definition = function(
    input,
    value,
    field,
    field_2,
    resolve_by,
    outer,
    resolve,
    strict,
    ...
  ) {
    
  ## Argument checks //
  strict <- as.numeric(match.arg(as.character(strict), 
    as.character(c(0, 1, 2))))   
  
  struc <- getStructure(input = input, extended = TRUE)
        
  if (!all(value %in% struc[[field]])) {
    if (!length(field_2) || !all(value %in% struc[[field_2]])) {
      out <- if (strict == 0) {
        list()
      } else if (strict == 1) {
        conditionr::signalCondition(
          condition = "Invalid",
          msg = c(
            Reason = "invalid retrieval value",
            Value = value,
            Available = paste(unique(struc[[field]]), collapse = ", ")
          ),
          ns = "listr",
          type = "warning"
        ) 
        list()
      } else if (strict == 2) {
        conditionr::signalCondition(
          condition = "Invalid",
          msg = c(
            Reason = "invalid retrieval value",
            Value = value,
            Available = paste(unique(struc[[field]]), collapse = ", ")
          ),
          ns = "listr",
          type = "error"
        ) 
      }
      return(out)
    }
    field <- field_2
  }

  index <- if (!outer) "index" else "oindex"
  expr <- parse(text = paste0("input", 
    struc[which(struc[[field]] %in% value), index]))

  nms <- if (!resolve) {
    struc[which(struc[[field]] %in% value), field]
  } else {
    if (!resolve_by %in% colnames(struc)) {
      conditionr::signalCondition(
        condition = "Invalid",
        msg = c(
          Reason = "invalid field for name substitution",
          Value = resolve_by,
          Available = paste(colnames(struc), collapse = ", ")
        ),
        ns = "listr",
        type = "error"
      ) 
    }
    struc[which(struc[[field]] %in% value), resolve_by]
  }
  nms[is.na(nms)] <- ""
  if (!length(nms)) {
    nms <- if (!resolve) value else ""
    nms <- ""
  } 

  envir <- environment()
  structure(lapply(expr, eval, envir = envir), names = nms)
    
  }
)

