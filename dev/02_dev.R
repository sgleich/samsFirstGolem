# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Amend DESCRIPTION with dependencies read from package code parsing
## install.packages('attachment') # if needed.
attachment::att_amend_desc()
usethis::use_package("ggplot2")
usethis::use_package("shiny")
usethis::use_package("reshape2")
usethis::use_package("lubridate")
usethis::use_package("tidyverse",type="depends")

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "filter_mod") # Name of the module
golem::add_fct("subsetTax")


## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "spot_data", open = FALSE)



