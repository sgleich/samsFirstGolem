# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
##
## /!\ Note: if you want to change the name of your app during development,
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
##
golem::fill_desc(
  pkg_name = "samsFirstGolem", # The Name of the package containing the App
  pkg_title = "samsFirstGolemPkg", # The Title of the package containing the App
  pkg_description = "Golem desc.", # The Description of the package containing the App
  author_first_name = "Samantha", # Your First Name
  author_last_name = "Gleich", # Your Last Name
  author_email = "gleich@usc.edu", # Your Email
  repo_url = "https://github.com/sgleich/samsFirstGolem.git", # The URL of the GitHub Repo (optional),
  pkg_version = "0.0.0.9000" # The Version of the package containing the App
)

## Set {golem} options ----
golem::set_golem_options()


## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license("Golem User") # You can set another license here
usethis::use_readme_rmd(open = FALSE)

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()
golem::use_recommended_deps()


## Add helper functions ----
golem::use_utils_ui()
golem::use_utils_server()

# You're now set! ----

#golem::run_dev()

