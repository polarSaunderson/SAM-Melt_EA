## ############# ##
## su01_set_up.R ##
## ############# ##

# SCRIPT OVERVIEW ##############################################################
# Author:     Dominic Saunderson      [ dominicSaunderson@gmail.com ]
#
# Purpose:    Sets up any basics that we use in every notebook
#
# Comments: - You shouldn't need to do anything here.
#           - Just make sure that the necessary packages have been installed
#             from https://github.com/polarSaunderson
#

# User Settings ################################################################
u_user <- "polarSaunderson"

# Load Personal Packages #######################################################
# These must have been installed from GitHub
library(domR)
library(kulaR)
library(figuR)
library(terrapin)
library(polarcm)

# Test
domR::test_function(u_user)

# Basics
domR::get_latest_git(display = TRUE, incGitCommit = FALSE)
figPath <- domR::create_figure_directory()

# Configure polarcm
polarcm::configure_polarcm()

# Load custom functions created in the current project -------------------------
domR::source_folder("R/functions/")

access_project_globals() # pToken - list of commonly referred to variables
