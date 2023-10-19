linear_detrend <- function(x) {
  #' Linearly detrend a time series
  #' 
  #' @description Removes the mean value, and sets the gradient to zero on a 
  #'   time series.
  #' 
  #' @param x The time series to detrend.
  #' 
  #' @export 
  
  # Code -----------------------------------------------------------------------
  x <- stats::resid(lm(x ~ seq_along(x), na.action = na.exclude))
  return(x)
}
