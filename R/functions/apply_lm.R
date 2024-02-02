apply_lm <- function(xx, yy, detrend = FALSE){
  #' Calculate the regression, p-value and r^2 value between 2 variables
  #'
  #' @description This functions helps apply `lm` over a raster, and return
  #'   the relevant coefficients for plotting, and not as some weird list. In 
  #'   order, the three return values are: the regression value; the p-value;
  #'   and the coefficient of determination (r^2).
  #'
  #' @param xx vector: independent variable
  #' @param yy vector: dependent variable
  #' @param detrend BINARY: Should xx and yy be detrended before calculating the
  #'   values? Assumes a linear fit using `lm`, and then uses the residuals from
  #'   it.
  #'
  #' @examples
  #' \dontrun{
  #'   terra::app(x = t2m, xx = SAM, apply_lm)
  #' }
  #' @export
  
  # Code -----------------------------------------------------------------------
  if (isTRUE(detrend)) {
    # Detrend using a linear model
    xx <- linear_detrend(xx)
    yy <- linear_detrend(yy)
  }
  
  # Create a linear model
  xyModel <- lm(yy ~ xx) |> summary()
  
  # Extract relevant info
  regression <- xyModel$coefficients[2] # regression
  pValue     <- xyModel$coefficients[8] # p-value
  rSquared   <- xyModel$r.squared       # r-squared value
  
  return(c(regression, pValue, rSquared))
}
