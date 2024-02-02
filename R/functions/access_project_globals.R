access_project_globals <- function(refresh = FALSE){
  #' Provides variables that are necessary throughout the project
  #'
  #' @description There are a number of variables that are required by multiple
  #'   functions or notebooks; this functions provides them. So that it doesn't
  #'   repeatedly need to create things, it creates a list containing the output
  #'   in the global environment (pToken).
  #'
  #' @param refresh BINARY: Should the guard be overruled and this function run 
  #'   again?
  
  # Code -----------------------------------------------------------------------
  if (isTRUE(exists("pToken", envir = .GlobalEnv)) & isFALSE(refresh)) {
    token <- .GlobalEnv$pToken
  } else {
    # Ice Shelves
    shelves <- c("Brunt_Stancomb", "Riiser-Larsen", 
                 "Ekstrom", "Atka", "Jelbart", 
                 "Fimbul","Vigrid", "Nivl", "Lazarev", 
                 "Borchgrevink", "Baudouin", "Prince_Harald",
                 "Amery", 
                 "West", "Shackleton", "Tracy_Tremenchus", "Conger_Glenzer",
                 "Totten", "Moscow_University", "Holmes", 
                 "Mertz", "Ninnis", "Cook", "Rennick", 
                 "Mariner", "Nansen", "Drygalski")
    
    shelfTitles <- c("Brunt", "R.-Larsen", 
                    "Ekstrom", "Atka", "Jelbart",
                    "Fimbul", "Vigrid", "Nivl", "Lazarev", 
                    "B'grevik", "Baudouin", "Pr. Harald", 
                    "Amery", 
                    "West", "Shackleton", "Tracy T.", "Conger", 
                    "Totten", "Moscow U.", "Holmes", 
                    "Mertz", "Ninnis", "Cook", "Rennick",
                    "Mariner", "Nansen", "Drygalski")
    
    shelfInitials <- c("BS", "RL", 
                       "Ek", "At", "Jb", 
                       "Fm", "Vg", "Nv", "Lz", 
                       "Bg", "Ba", "PH",
                       "Am", 
                       "Ws", "Sh", "TT", "CG", 
                       "To", "MU", "Hm",
                       "Mz", "Nn", "Ck", "Rn", 
                       "Ma", "Na", "Dr")
    
    # Variable Source
    varERA5 <- c("mslp", "z850", "z700", "z500", "z250")
    varRACMO <- .polarEnv$varNames$racmoM$rp3
    
    # Variable type
    varTemperature  <- c("t2m", "tskin")
    varGeopotential <- c("z850", "z700", "z500", "z250")
    varPressure <- c("mslp")
    varWind <- c("w10m", "v10m", "u10m")
    varMass <- c("smb", "precip", "sndiv", "subl", 
                 "totwat", "refreeze", "runoff", 
                 "snowmelt", "meltsur", "meltin", "melt")
    varEnergy <- c("seb", "turb", "radi",
                   "swsn", "swsd", "swsu",
                   "lwsn", "lwsd", "lwsu",
                   "senf", "latf", "gbot",
                   "swabsin")
    
    # Variable austral behaviour
    varSummable <- c("swsn", "swsu", "swsd", "swabsin",
                     "lwsn", "lwsu", "lwsd",
                     "seb", "radi", "turb",
                     "latf", "senf", "gbot",
                     "snowmelt", "meltsur", "meltin", "melt",
                     "totwat", "refreeze", "runoff", 
                     "smb", "precip", "sndiv", "subl")
    
    varMeanable <- c("t2m", "tskin", 
                     "albd",
                     "mslp", "z850", "z700", "z500", "z250",
                     "w10m", "v10m", "u10m")
    
    # Create a list to store
    token <- list("shelves" = shelves,
                  "initials" = shelfInitials,
                  "shelfTitles" = shelfTitles,
                  "varMeanable" = varMeanable,
                  "varSummable" = varSummable,
                  "varRACMO" = varRACMO,
                  "varERA5" = varERA5,
                  "varTemperature" = varTemperature,
                  "varGeopotential" = varGeopotential,
                  "varPressure" = varPressure,
                  "varEnergy" = varEnergy,
                  "varMass" = varMass,
                  "varWind" = varWind)
    .GlobalEnv$pToken <- token
  }
  return(token)
}
