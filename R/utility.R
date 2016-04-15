#' Require, and first install from CRAN if necessary, a list of packages.
#'
#' This function will load packages to your project using the require function.
#' First, however, it will try to install them from CRAN. Thus, you can use this
#' function to install and require packages in one go, so as not to worry about
#' which packages you do or do not have installed on your system. Note that
#' installing from CRAN means that packages will not be installed if they do not
#' exist on CRAN. However, if they're already installed on your system, they
#' will still be loaded.
#'
#' @export
#' @param ... Package names as strings.
#' @examples
#' attachPackages("data.table", "pipeR")
attachPackages <- function (...) {
  list.of.packages <- c(...)
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}


#' Print a text progress bar to the console.
#'
#' Use this function to monitor the progress of loops.
#'
#' @export
#' @param current Numeric. Current iteration value.
#' @param min, max (finite) numeric values for the extremes of the progress bar. Must have min < max.
#' @param style the ‘style’ of the bar – see ‘Details’ in ?txtProgressBar.
#' @examples
#' for (b in 1:10000) {
#'   trackProgress(b, B)
#' }
trackProgress <- function(current, max = 1, min = 0, style = 3) {
  if(current == 1)
    pb <<- txtProgressBar(min = min, max = max, style = style)
  setTxtProgressBar(pb, current)
  if(current == max) {
    close(pb)
    rm(pb, pos = ".GlobalEnv")
  }
}
