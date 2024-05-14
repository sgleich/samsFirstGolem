#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # We are now calling the module server functions
  # on a given id that matches the one from the UI
  filteredData <- mod_filter_server("filter_mod_1")
  mod_plot_server("try_mod_1",filteredData)
  filteredData2 <- mod_filter_server("filter_mod_2")
  mod_plotTreat_server("plotTreat_1",filteredData2)
}


