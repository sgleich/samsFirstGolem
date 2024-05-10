#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # We are now calling the module server functions
  # on a given id that matches the one from the UI
  filteredData <- mod_filter_mod_server("filter_mod_1")
  mod_try_mod_server("try_mod_1",filteredData)
}


