source("renv/activate.R")

# Add any rstudioapi calls to run upon opening the project in RStudio
setHook("rstudio.sessionInit", 
        function(newSession) {
          if (newSession) {
            rstudioapi::navigateToFile("README.md")
          }
        },  
        action = "append")

# polarcm ======================================================================
if (!exists(".polarEnv")) .polarEnv <- new.env()

## Raw Data Path ---------------------------------------------------------------
.polarEnv$rawDataPath  <- "../../Data/"

## MEaSURES Data Path ----------------------------------------------------------
.polarEnv$MEaSURES     <- "MEaSURES Boundaries/"

## Monthly RACMO Data Paths ----------------------------------------------------
.polarEnv$rcm$racmoM$rp3   <- list(
  "dir" = "RACMO/RACMO2.3p3/RACMO2.3p3_CON_ANT27_monthly/",
  "src" = "10.5281/zenodo.5512076")

## Daily RACMO Data Paths ------------------------------------------------------
.polarEnv$rcm$racmoD$rp3   <- list(
  "dir" = "RACMO/RACMO2.3p3/RACMO2.3p3_CON_ANT27_daily/",
  "src" = "10.5281/zenodo.5512076") # matches the monthly data

## .polarEnv should be ready! --------------------------------------------------
.polarEnv$testing <- "Gooooood luck & enjoy!!!"
