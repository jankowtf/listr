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
  .computeOuterIndex <- function(x) {
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
  .combineNameElements <- function(x, sep = "/") {
    paste(as.character(na.omit(x)), collapse = sep)
  }
  .createPathNames <- function(x, name_vec) {
    y <- x
    sapply(1:ncol(x), function(col) {
      idx <- which(!duplicated(x[,col]) & !is.na(x[,col]))
      sapply(seq(along = idx), function(ii) {
        row <- idx[ii]
        pos <- as.character(x[row, col])
        val <- if (!is.na(name_vec[row])) name_vec[row] else pos
        x[!is.na(x[, col]) & x[, col] == x[row, col], col] <<- val
        y[!is.na(y[, col]) & y[, col] == y[row, col], col] <<- pos
      })
    })
    data.frame(
      path = apply(x, 1, .combineNameElements),
      ppath = apply(y, 1, .combineNameElements),
      stringsAsFactors = FALSE
    )
  }

  ## Columns to temporarily exclude //
#   idx_excl <- which(colnames(input) %in% c("name", "class", "str"))
  idx_excl <- which(colnames(input) %in% c("name", "class", "str", "level", "dim"))
  excl <- input[,idx_excl]

  ## PATCH //
  do_level <- if (!"level" %in%colnames(input)) TRUE else FALSE
  
  ## Substitute zeros with NAs //
  input <- as.data.frame(apply(input[,-idx_excl, drop = FALSE], 
    2, .substituteZeros))
  
  f <- input[,1]
  spl <- split(input, f = f)
  excl_spl <- split(excl, f = f)

  input <- lapply(seq(along = spl), function(ii) {
    .main <- spl[[ii]]
    .excl <- excl_spl[[ii]]
    
    .level <- if (do_level) {
      apply(.main, 1, .computeLevel)
    } else {
      NULL
    }
    .index <- apply(.main, 1, .computeIndex)
    .outer_index <- apply(.main, 1, .computeOuterIndex)
    .path <- .createPathNames(x = .main, name_vec = .excl$name)
    
    .leaf <- rep(FALSE, nrow(.main))
    .leaf[which(.level == which.max(.level))] <- TRUE
    .type <- sapply(as.character(.leaf), switch, "FALSE" = 2, "TRUE" = 3)
    if (length(.type) > 1) {
      .type[1] <- 1
    } else {
      .type <- 3
    }
    if (do_level) {
      data.frame(.main, level = .level, type = .type, index = .index, 
        oindex = .outer_index, .path, stringsAsFactors = FALSE)
    } else {
      data.frame(.main, type = .type, index = .index, 
        oindex = .outer_index, .path, stringsAsFactors = FALSE)
    }
  })
  out <- unsplit(input, f = f)
  listr::ExtendedObjectStructure.S3(
    .x = data.frame(out, excl, stringsAsFactors = FALSE)
  )

  }
)

