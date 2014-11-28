#' @title
#' Extended List Functionalities
#'
#' @description
#' The package provides extended functionality for working with lists
#' 
#' @section Core functions:
#' 
#'  \itemize{
#'    \item{\code{\link[listr]{getStructure}}: }{
#'
#'      Retrieve list structure.
#'    }
#'    \item{\code{\link[listr]{getByType}}: }{
#'
#'      Retrieve values by \code{type} as returned by 
#'      \code{\link[listr]{getStructure}}
#'    }
#'    \item{\code{\link[listr]{getByLevel}}: }{
#'
#'      Retrieve values by \code{level} as returned by 
#'      \code{\link[listr]{getStructure}}
#'    }
#'    \item{\code{\link[listr]{getByName}}: }{
#'
#'      Retrieve values by \code{name} as returned by 
#'      \code{\link[listr]{getStructure}}
#'    }
#' }
#' 
#' @section Core classes:
#' 
#'  \itemize{
#'    \item{\code{\link[listr]{ExtendedObjectStructure.S3}}: }{
#'
#'      Class to represent extended object structures
#'    }
#'  }
#'  
#' @section Classes with internal character:
#' 
#'  \itemize{
#'    \item{\code{\link[listr]{ObjectStructure.S3}}: }{
#'
#'      Class to represent regular object structure objects
#'    }
#'    \item{\code{\link[listr]{RawObjectStructure.S3}}: }{
#'
#'      Class to represent raw object structure objects
#'    }
#' }
#'
#' @template author
#' @template references
#' @docType package
#' @name listr
NULL
