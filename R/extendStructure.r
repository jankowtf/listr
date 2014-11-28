#' @title
#' Extend Structure (generic)
#'
#' @description 
#' Extends object structure as returned by \code{\link[listr]{extendStructure}}.
#'   	
#' @param input \strong{Signature argument}.
#'    Object containing structure information.
#' @template threedots
#' @example inst/examples/extendStructure.r
#' @seealso \code{
#'   	\link[listr]{extendStructure-ObjectStructure.S3-method},
#'     \link[listr]{getStructure}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "extendStructure",
  signature = c(
    "input"
  ),
  def = function(
    input,
    ...
  ) {
    standardGeneric("extendStructure")       
  }
)

#' @title
#' Extend Structure (ObjectStructure.S3)
#'
#' @section See generic: 
#' \code{\link[listr]{extendStructure}}
#'      
#' @inheritParams extendStructure
#' @param input \code{\link{list}}.
#' @return \code{\link[listr]{ExtendedObjectStructure.S3}}. 
#'    A \code{data.frame} like 
#'    representation of structural information with an additional class 
#'    attribute.
#' @example inst/examples/extendStructure.r
#' @seealso \code{
#'    \link[listr]{extendStructure},
#'    \link[listr]{getStructure},
#'    \link[listr]{ObjectStructure.S3},
#'    \link[listr]{ExtendedObjectStructure.S3}
#' }
#' @template author
#' @template references
#' @aliases extendStructure-list-method
#' @import stringr
#' @export
setMethod(
  f = "extendStructure", 
  signature = signature(
    input = "ObjectStructure.S3"
  ), 
  definition = function(
    input,
    ...
  ) {
    
  ## Private functions //
  .substituteZeros <- function(x) {
    x[!x] <- NA
    x
  }
  .computeLevel <- function(x) {
    length(na.omit(as.numeric(x)))
  }
  .computeIndex <- function(x) {
    x <- as.numeric(na.omit(x))
#     paste0("[[", paste(x, collapse = "]][["), "]]")
    sprintf("[[%s]]", paste(x, collapse = "]][["))
  }
  .computeParentIndex <- function(x) {
    x <- as.numeric(na.omit(x))
    if (length(x) > 1) {
      sprintf("[[%s]]%s", 
        paste(x[-length(x)], collapse = "]][["),
        sprintf("[%s]", x[length(x)])
      )  
    } else {
      sprintf("[%s]", x)
    }
  }

  ## Columns to temporarily exclude //
  idx_excl <- which(colnames(input) %in% c("name", "class", "str"))
  input_excl <- input[,idx_excl]
  input <- input[,-idx_excl, drop = FALSE]
  
  ## Substitute zeros with NAs //
  tmp <- as.data.frame(apply(input, 2, .substituteZeros))
  
  f <- tmp[,1]
  spl <- split(tmp, f = f)
  tmp <- lapply(spl, function(ii) {
#     info <- lapply(1:nrow(ii), function(ii2) {
#       data.frame(
#         level = length(na.omit(as.numeric(ii[ii2,,drop = TRUE]))),
#         index = paste0("[[", paste(na.omit(as.numeric(ii[ii2,,drop = TRUE])), 
#           collapse = "]][["), "]]"),
#         stringsAsFactors = FALSE
#       )
#     })
#     info <- do.call("rbind", info)
    ## --> works, but probably slower than using `apply()`
    ## Keep as reference
    
    .level <- apply(ii, 1, .computeLevel)
    .index <- apply(ii, 1, .computeIndex)
    .parent_index <- apply(ii, 1, .computeParentIndex)
    
    .leaf <- rep(FALSE, nrow(ii))
    .leaf[which(.level == which.max(.level))] <- TRUE
    .type <- sapply(as.character(.leaf), switch, "FALSE" = 2, "TRUE" = 3)
    if (length(.type) > 1) {
      .type[1] <- 1
    } else {
      .type <- 3
    }
    data.frame(ii, level = .level, type = .type, index = .index, 
      pindex = .parent_index, stringsAsFactors = FALSE)
  })
  out <- unsplit(tmp, f = f)
  listr::ExtendedObjectStructure.S3(
    .x = data.frame(out, input_excl, stringsAsFactors = FALSE)
  )
    
  }
)

