align_enso_to_summers <- function(index = 34, since = 1979, australSplit = 3) {
  #' Accesses the monthly ENSO data from NOAA and aligns to summers, not years
  #'
  #' @description The ENSO indices are provided by NOAA with each row holding 
  #' data for a year. However, because we are looking at the austral summer, we 
  #' are often splitting across these rows, and it is just easier to align 
  #' everything by summer at the start.
  #' 
  #' @param since numeric: Which is the first summer to include?
  #' @param index numeric: Which ENSO index? Options are 3, 4, 34, 12.
  #' @param australSplit Which is the last month of an austral summer / year
  #'   before the new austral summer / year begins? The default value is 3, 
  #'   which means that all months *AFTER* March are considered part of the 
  #'   following summer (i.e. April 1991--March 1992 are all in summer 1992). 
  #'   Swap this value accordingly: set it as 4 means May 1991--April 1992 are 
  #'   all summer 1992.
  
  # Code -----------------------------------------------------------------------
  # Read in raw data 
  rawInput <- read.table(paste0("https://psl.noaa.gov/gcos_wgsp/Timeseries/Data/", 
                                "nino", index, 
                                ".long.anom.data"),
                         header = FALSE,
                         skip = 1, 
                         nrows = length(1870:2023)) |> 
    as.data.frame() |> 
    `colnames<-`(c("Year", month.abb)) |>
    `row.names<-`(1870:2023)
  
  # Sift the raw data
  rawInput <- domR::sift(rawInput, paste0("rownames > ", since - 1))
  rawInput[rawInput == -99.99] <- NA
  
  # (australSplit+1)--Dec from year yr-1, Jan--australSplit from year yr
  enso  <- data.frame("Summer" = as.numeric(rownames(rawInput)) + 1,
                      rawInput[, ((australSplit + 1):12)+1],
                      rbind(rawInput[-1, 2:(australSplit)], NA))
  
  # Rename rows to match the summers 
  rownames(enso) <- enso$Summer
  
  return(enso)
}
