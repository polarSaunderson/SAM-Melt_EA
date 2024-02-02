##
align_sam_to_summers <- function(filePath = "noaa", 
                                 since = 1980, 
                                 australSplit = 3) {
  #' Align monthly SAM data to summers, not years
  #' 
  #' @description The SAM index is provided with each year representing a row.
  #'   If we are interested in the austral summer / year, it is necessary to 
  #'   split across these rows.
  #'   
  #' @param since Which is the first summer of the SAM data to include? If NULL,
  #'   all summers with data are returned.
  #' @param filePath Where is the SAM data on your system? Either add a relative
  #'   path to the current working directory. Alternatively, simply input "noaa" 
  #'   or "marshall" if the data is stored in a "../../Data/Climate_Indices/SAM/"
  #'   directory as either "sam_NOAA_monthly.csv", or "sam_Mars2003_monthly.csv".
  #'   The data can be downloaded from:
  #'   - (NOAA):     https://www.cpc.ncep.noaa.gov/products/precip/CWlink/daily_ao_index/aao/monthly.aao.index.b79.current.ascii.table
  #'   - (Marshall): http://www.nerc-bas.ac.uk/public/icd/gjma/newsam.1957.2007.txt
  #'   It needs to be tidied.
  #'   
  #' @param australSplit Which is the last month of an austral summer / year
  #'   before the new austral summer / year begins? The default value is 3, 
  #'   which means that all months *AFTER* March are considered part of the 
  #'   following summer (i.e. April 1991--March 1992 are all in summer 1992). 
  #'   Swap this value accordingly: set it as 4 means May 1991--April 1992 are 
  #'   all summer 1992.
  #'   
  
  # Code -----------------------------------------------------------------------
  # Find the csv data
  if (filePath == "marshall") {
    filePath <- paste0("../../Data/Climate Indices/SAM/",
                       "sam_Mars2003_monthly.csv")
  } else if (filePath == "noaa") {
    filePath <- paste0("../../Data/Climate Indices/SAM/",
                       "aao_NOAA_monthly.csv")
  } else {
    filePath <- filePath
  }
  
  # Read in raw data and sift it
  rawInput <- utils::read.csv(filePath, sep = "")
  rawInput <- domR::sift(rawInput, paste("rownames >", since - 2)) # handles summer
  
  # Create a dataframe with the months aligned to austral summers
  samData  <- data.frame("Summer" = as.numeric(rownames(rawInput)) + 1,
                         rawInput[, (australSplit + 1):12],
                         rbind(rawInput[-1, 1:australSplit], NA))
  
  # Rename rows to match summers
  rownames(samData) <- samData$Summer
  
  # Capitalise initial letter of column titles
  colnames(samData) <- domR::make_title_case(colnames(samData))
  
  # Return dataframe
  return(samData)
}
