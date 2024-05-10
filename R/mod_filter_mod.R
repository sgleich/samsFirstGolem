#' filter_mod UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_filter_mod_ui <- function(id) {
  ns <- NS(id)
  shiny::tagList(
    shiny::selectInput(ns("taxInput"), "Select Taxonomic Group:", choices = c("Whole Community",unique(periData$Group)))
  )
}


#' filter_mod Server Functions
#'
#' @noRd
mod_filter_mod_server <- function(id){
  shiny::moduleServer( id, function(input,output,session){
    ns <- session$ns
    filteredData <- shiny::reactive({
      if(input$taxInput != "Whole Community"){
        return(periData %>% filter(Group == input$taxInput) %>% subsetTax(tax=input$taxInput))
      } else{
          return(periData %>% subsetTax(tax="Whole Community"))
        }
      })
    return(filteredData)})}

## To be copied in the UI
# mod_filter_mod_ui("filter_mod_1")

## To be copied in the server
# mod_filter_mod_server("filter_mod_1")
