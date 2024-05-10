#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  shiny::fluidPage(
    shiny::titlePanel("PERIFIX Experiment"),
        shiny::h5("PERIFIX Experiment shiny app made using a {golem} framework"),
        mod_filter_mod_ui("filter_mod_1"),
        mod_try_mod_ui("try_mod_1"),
      shiny::mainPanel(
        # Placeholder for the plot
      )
    )
  }




