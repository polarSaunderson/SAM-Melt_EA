prep_racmo_names <- function(racmoVars,
                             before = NULL,
                             after = NULL,
                             bracket1 = NULL,
                             bracket2 = NULL,
                             originalUnits = TRUE,
                             monthlyData = FALSE,
                             shortName = TRUE) {
  #' DO NOT USE THIS BEYOND THIS PROJECT!!! IT FAILS MANY TESTS & IS IN PROGRESS
  #'
  #' Help with labelling of RACMO variables and units
  #'
  #' @description The shortened variable names (e.g. "senf") are not always 
  #'   clear on a plot. Instead, we usually want a full or abbreviated name, and 
  #'   possibly the units as well (for example "Sensible Heat Flux (W m-2)".
  #'
  #'   Those changes requires a lot of repeated typing prone to mistakes,
  #'   particularly when concerned with the superscripts and subscripts with
  #'   [bquote()]. This function is (a work-in-progress) way to automate this.
  #'
  #'   The text is composed of nine spots; anything NULL or NA is removed. The
  #'   order is: NA before NA name NA units NA after NA
  #'
  #'   Brackets (bracket1, bracket2) can be added to any 2 of the NA locations.
  #'
  #' @param racmoVars Which RACMO variable/s to use? Use the short name code. If
  #'   a vector with multiple racmoVars is provided, a list of expressions is
  #'   returned.
  #' @param before Text to put at the start.
  #' @param after Text to put at the end.
  #' @param bracket1 Where should an opening bracket go? Must be 1, 3, 5, 7, or
  #'   9.
  #' @param bracket2 Where should the closing bracket go? Must be 1, 3, 5, 7, or
  #'   9.
  #' @param originalUnits Should the same units as the dataset be used (TRUE;
  #'   default)? Usually this makes the most sense, but some of the variables
  #'   are often changed in the same way for ease of use. For example, it is
  #'   usually easier to think of snow/ice temperatures in Celsius rather than
  #'   Kelvin, to use Watts rather than total Joules, and to think of melt or
  #'   precipitation as daily totals rather than fluxes per second.
  #'
  #'   Be *VERY VERY VERY* careful if setting this as FALSE - it just assumes
  #'   that the changes are the common ones that I have previously done. There
  #'   is nothing clever about it! Set this argument or 'monthlyData' as NULL to 
  #'   suppress the unit in the returned expression.
  #' @param monthlyData Is the RACMO data monthly resolution (i.e. racmoM; TRUE)
  #'   or daily (i.e. racmoD; FALSE, the default)? For some variables, this
  #'   makes a difference (e.g. all radiative fluxes are in Joules in monthly
  #'   data, but Watts in monthly data). For other variables (e.g. "t2m",
  #'   "u10m") it makes no difference. Set as NA to exclude the "day-1" or 
  #'   "month-1" part. Set this or 'originalUnits' as NULL to suppress the unit 
  #'   output in the returned expression.
  #' @param shortName Should shortened names ("Precip.") or acronyms ("SMB") be
  #'   used over the full name (e.g. "Precipitation", "Surface Mass Balance")?
  #'   If set as NULL, the variable name is suppressed in the returned
  #'   expression.
  #' @noRd
  
  # Code -----------------------------------------------------------------------
  # Prep
  before <- set_if_null(before, NA)
  after  <- set_if_null(after, NA)
  
  # Prep for brackets
  if (!is.null(monthlyData) & !is.null(originalUnits)) {
    bracket1 <- set_if_null(bracket1, 5)
    bracket2 <- set_if_null(bracket2, 7)
  } else {
    bracket1 <- set_if_null(bracket1, NA)
    bracket2 <- set_if_null(bracket2, NA)
  }
  b1 <- NA; b3 <- NA; b5 <- NA; b7 <- NA; b9 <- NA
  
  # Guard against incorrect bracket use
  if (!is.na(bracket1) & !is.na(bracket2)) {
    if (bracket1 > bracket2) stop("bracket1 must come before bracket2!")
    if (bracket1 == bracket2) stop("bracket1 and bracket2 can't match!")
    if (bracket1 %notIn% c(1, 3, 5, 7, 9)) stop("bracket1 must be 1, 3, 5, 7 or 9!")
    if (bracket2 %notIn% c(1, 3, 5, 7, 9)) stop("bracket2 must be 1, 3, 5, 7 or 9!")
    
    if (bracket1 == 1) b1 <- " ("
    if (bracket1 == 3) b3 <- " ("
    if (bracket1 == 5) b5 <- " ("
    if (bracket1 == 7) b7 <- " ("
    if (bracket1 == 9) b9 <- " ("
    
    if (bracket2 == 1) b1 <- ") "
    if (bracket2 == 3) b3 <- ") "
    if (bracket2 == 5) b5 <- ") "
    if (bracket2 == 7) b7 <- ") "
    if (bracket2 == 9) b9 <- ") "
  }
  
  # Preallocate - allows multiple racmoVars to be entered at once
  nameList <- list()
  
  for (iiVar in racmoVars) {
    # Name Part ------------------------------------------------------------------
    if (isFALSE(shortName)) {
      nameBit <- switch(iiVar,
                        "precip"   = "Precipitation",
                        "smb"      = "Surface Mass Balance",
                        "sndiv"    = "Snow Drift",
                        "refreeze" = "Surface Refreezing",
                        "runoff"   = "Surface Runoff",
                        "subl"     = "Sublimation",
                        "snowmelt" = "Surface Melt Flux",
                        "t2m"      = "Surface (2m) Air Temperatures",
                        "albd"     = ,
                        "albedo"   = "Surface Albedo",
                        "swsn"     = "Net Shortwave Radiation",
                        "swsd"     = "Incoming Shortwave Radiation",
                        "swsu"     = "Outgoing Shortwave Radiation",
                        "lwsn"     = "Net Longwave Radiation",
                        "lwsd"     = "Incoming Longwave Radiation",
                        "lwsu"     = "Outgoing Longwave Radiation",
                        "radi"     = "Net Radiative Fluxes",
                        "turb"     = "Net Turbulent Fluxes",
                        "senf"     = "Sensible Heat",
                        "latf"     = "Latent Heat",
                        "gbot"     = "Ground Heat Flux",
                        "seb"      = "Surface Energy Balance",
                        "mslp"     = "MSL Pressure",
                        "wind"     = "Absolute Wind Speed",
                        "w10m"     = "Absolute Wind Speed",
                        "v10m"     = "Meridional Wind Speed",
                        "u10m"     = "Zonal Wind Speed")
    } else if (isTRUE(shortName)) {
      nameBit <- switch(iiVar,
                        "precip"   = "Precipitation",
                        "smb"      = "SMB",
                        "sndiv"    = "Snow Drift",
                        "refreeze" = "Refreezing",
                        "runoff"   = "Runoff",
                        "subl"     = "Subl.",
                        "snowmelt" = "Surface Melt",
                        "melt"     = "Melt",
                        "t2m"      = bquote(~T["2m"]),
                        "albd"     = ,
                        "albedo"   = "Albedo",
                        "swsn"     = bquote(~SW["NET"]),
                        "swsd"     = bquote(~SW["IN"]),
                        "swsu"     = bquote(~SW["OUT"]),
                        "lwsn"     = bquote(~LW["NET"]),
                        "lwsd"     = bquote(~LW["IN"]),
                        "lwsu"     = bquote(~LW["OUT"]),
                        "radi"     = bquote(~Radiative["NET"]),
                        "turb"     = bquote(~Turbulent["NET"]),
                        "senf"     = "Sensible Heat",
                        "latf"     = "Latent Heat",
                        "gbot"     = "Ground Heat",
                        "seb"      = "SEB",
                        "mslp"     = "MSLP",
                        "wind"     = "Wind Speed",
                        "w10m"     = "Wind Speed",
                        "v10m"     = "Meridional Winds",
                        "u10m"     = "Zonal Winds")
    } else if (is.null(shortName)) {
      nameBit <- NA
    }
    
    # Original Units -----------------------------------------------------------
    if (iiVar %in% pToken$varMass) {
      if (isFALSE(monthlyData)) {
        unitBit <- bquote("kg"~m^-2~s^-1)
      } else if (isTRUE(monthlyData)) {
        unitBit <- bquote("kg"~m^-2~month^-1)
      } else if (is.na(monthlyData)) {
        unitBit <- bquote("kg"~m^-2)
      }
    } else if (iiVar %in% pToken$varEnergy) {
      if (isFALSE(monthlyData)) {
        unitBit <- bquote("W"~m^-2)
      } else if (isTRUE(monthlyData)) {
        unitBit <- bquote("J"~m^-2)
      }      
    } else if (iiVar %in% pToken$varTemperature) {
      unitBit <- "K"
    } else if (iiVar %in% pToken$varWind) {
      unitBit <- bquote("m"~s^-1)
    } else if (iiVar %in% c("albd", "albedo")) {
      unitBit <- ""
    } else if (iiVar %in% pToken$varGeopotential) {
      unitBit <- "m"
    } else if (iiVar %in% pToken$varPressure) {
      unitBit <- "Pa"
    } else if (iiVar %in% pToken$varGeopotential) {
      unitBit <- bquote(m^2~s^-2)
    }
    
    # Common unit changes ------------------------------------------------------
    # There is nothing clever about this, it just assumes the common changes
    # that I have done previously. Do NOT try to use outside of the very narrow
    # context in which it is currently used in phd02.
    if (isFALSE(originalUnits)) {
      if (iiVar %in% pToken$varMass) {
        if (isFALSE(monthlyData)) {
          unitBit <- bquote("kg"~m^-2~day^-1)
        } else if (is.na(monthlyData)) {
          unitBit <- bquote("kg"~m^-2)
        }
      } else if (iiVar %in% pToken$varEnergy) {
        if (isTRUE(monthlyData)) {
          unitBit <- bquote("W"~m^-2~day^-1)
        } else if (is.na(monthlyData)) {
          unitBit <- bquote("W"~m^-2)
        }
      } else if (iiVar %in% pToken$varPressure) {
        unitBit <- "hPa"
      } else if (iiVar %in% pToken$varTemperature) {
        unitBit <- "\u00B0C"
      } else if (iiVar %in% c("albd", "albedo")) {
        unitBit <- "%"
      } else if (iiVar %in% pToken$varGeopotential) {
        unitBit <- "m"
      }
    }
    
    if (is.null(monthlyData) | is.null(originalUnits)) {
      unitBit <- NA
    }
    
    # Combine into a full name (complex as using expressions)
    nameList[[iiVar]] <- substitute(b1~before~b3~nameBit~b5~unitBit~b7~after~b9, 
                                    list(nameBit = nameBit, unitBit = unitBit, 
                                         before = before, after = after,
                                         b1 = b1, b3 = b3, b5 = b5, 
                                         b7 = b7, b9 = b9))
    
  }
  
  # If only one, unlist it so it is easier to use
  if (length(racmoVars) == 1) {
    nameList <- nameList[[iiVar]]
  }
  
  return(nameList)
}
