#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  shiny::navbarPage("PERIFIX {golem} App",
                    h5("Welcome to the PERIFIX Experiment interactive web application. This application was made using the {golem} Shiny framework."),
                    shiny::tabPanel("Treatment vs. Abundance",
                                    shiny::mainPanel(mod_filterTax_ui("filter_mod_1"),mod_plotDate_ui("try_mod_1"))),
                    shiny::tabPanel("Date vs. Abundance",
                                    shiny::mainPanel(mod_filterTax_ui("filter_mod_2"),mod_plotTreat_ui("plotTreat_1"))),
                    shiny::tabPanel("NMDS Plots",
                                    shiny::mainPanel(mod_runNMDS_ui("runNMDS_1"))))}




