#' @title
#' Get Structure (generic)
#'
#' @description 
#' Retrieves the structural components of an object.
#'   	
#' @param input \strong{Signature argument}.
#'    Object whose structure should be retrieved.
#' @param extended \code{\link{logica.}}.
#'    \code{TRUE}: extended structure;
#'    \code{FALSE}: updated raw structure.
#' @template threedots
#' @example inst/examples/getStructure.r
#' @seealso \code{
#'   	\link[listr]{getStructure-list-method},
#'     \link[listr]{getRawStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getStructure",
  signature = c(
    "input"
  ),
  def = function(
    input,
    extended = TRUE,
    ...
  ) {
    standardGeneric("getStructure")       
  }
)

#' @title
#' Get Structure (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getStructure}}
#'      
#' @inheritParams getStructure
#' @param input \code{\link{list}}.
#' @return See method 
#'    \code{\link[listr]{getStructure-RawObjectStructure.S3-method}}. 
#' @example inst/examples/getStructure.r
#' @seealso \code{
#'    \link[listr]{getStructure},
#'    \link[listr]{getStructure-RawObjectStructure.S3},
#'    \link[listr]{ObjectStructure.S3},
#'    \link[listr]{getRawStructure}
#' }
#' @template author
#' @template references
#' @aliases getStructure-list-method
#' @import stringr
#' @export
setMethod(
  f = "getStructure", 
  signature = signature(
    input = "list"
  ), 
  definition = function(
    input,
    extended,
    ...
  ) {

  getStructure(
    input = getRawStructure(input = input),
    extended = extended,
    ...
  )
  
  }
)

#' @title
#' Get Structure (RawObjectStructure.S3)
#'
#' @section See generic: 
#' \code{\link[listr]{getStructure}}
#'      
#' @inheritParams getStructure
#' @param input \code{\link{list}}.
#' @return \code{\link[listr]{ObjectStructure.S3}}. A \code{data.frame} like 
#'    representation of structural information with an additional class 
#'    attribute.
#' @example inst/examples/getStructure.r
#' @seealso \code{
#'    \link[listr]{getStructure},
#'    \link[listr]{ObjectStructure.S3},
#'    \link[listr]{getRawStructure}
#' }
#' @template author
#' @template references
#' @aliases getStructure-list-method
#' @import stringr
#' @export
setMethod(
  f = "getStructure", 
  signature = signature(
    input = "RawObjectStructure.S3"
  ), 
  definition = function(
    input,
    extended,
    ...
  ) {
    
  ## Columns to temporarily exclude //
  idx_excl <- which(colnames(input) %in% c("name", "class", "str"))
  input_excl <- input[,idx_excl]
  input <- input[,-idx_excl, drop = FALSE]
  
  for (ii in 1:ncol(input)) {
    if (ii == 1) {
      input[,ii] <- cumsum(input[,ii])
    } else {
      f <- factor(apply(input[,1:(ii-1), drop = FALSE], 1, paste, collapse = "-"))
      spl <- split(input, f = f)
      out <- lapply(spl, function(ii) {
        tmp <- apply(ii, 2, cumsum)
        if (!is.matrix(tmp)) {
          tmp <- t(tmp)
        }
        data.frame(tmp, row.names = row.names(ii))
        ## NOTE //
        ## The class check and the transposition is necessary due to the way
        ## that `apply()` is designed (returning a vector if `n = 1`) if 
        ## `unsplit()` is to be applied (otherwise `do.call("rbind", out)` would
        ## have need to be called which is probably slower; not tested, though)
      })
      input[,ii] <- unsplit(out, f = f)[,ii]
    }
    NULL
  }
  out <- listr::ObjectStructure.S3(
    .x = data.frame(input, input_excl, stringsAsFactors = FALSE)
  )
  
  ## Extended //
  if (extended) {
    out <- extendStructure(input = out)
  }
  
  out
    
  }
)

