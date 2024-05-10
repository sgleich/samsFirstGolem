#' try_mod UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_try_mod_ui <- function(id){
  ns <- NS(id)
  shiny::tagList(
    shiny::selectInput(ns("date"), "Select Date:", choices = c("2021-08-11","2021-08-20","2021-08-27","2021-09-03","2021-09-07","2021-09-08")),
    shiny::actionButton(ns("go"),"Plot"),
    shiny::plotOutput(ns("plot"),height = "600px", width = "800px")
  )
}

#' try_mod Server Functions
#'
#' @noRd
mod_try_mod_server <- function(id, data){
  shiny::moduleServer( id, function(input,output,session){
    ns <- session$ns
    colrsPlot <- randomcoloR::distinctColorPalette(25)
    shiny::observeEvent(input$go,{
      output$plot <- renderPlot({
      filtered <- data()
      filtered <- filtered %>% filter(Date == input$date)

      ggplot2::ggplot(filtered, aes(x=Treatment,y=m,fill=taxFin))+geom_bar(stat="identity",position="fill",color="grey")+xlab("Treatment")+ylab("Relative Abundance")+scale_fill_manual(name="Taxonomic Group",values=c(colrsPlot))+theme_classic(base_size=24)+theme(axis.text.x=element_text(angle=45,hjust=1))
    })})})}

## To be copied in the UI
# mod_try_mod_ui("try_mod_1")

## To be copied in the server
# mod_try_mod_server("try_mod_1")
