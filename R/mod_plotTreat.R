#' plotTreat UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plotTreat_ui <- function(id){
  ns <- NS(id)
  shiny::tagList(
    shiny::selectInput(ns("treat"), "Select Treatment:", choices = c("Control","+N","+N+P","+N+Fe","+N+P+Fe","+P","+Fe","+P+Fe")),
    shiny::actionButton(ns("go2"),"Plot"),
    shiny::plotOutput(ns("plot2"),height = "600px", width = "800px")
  )
}

#' plotTreat Server Functions
#'
#' @noRd
mod_plotTreat_server <- function(id,data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    set.seed(100)
    colrsPlot <- randomcoloR::distinctColorPalette(25)
    output$plot2 <- renderPlot({
      filtered <- data()
      filtered <- filtered %>% filter(Treatment == input$treat)

      ggplot2::ggplot(filtered, aes(x=Date,y=m,fill=taxFin))+geom_bar(stat="identity",position="fill",color="grey")+xlab("Date")+ylab("Relative Abundance")+scale_fill_manual(name="Taxonomic Group",values=c(colrsPlot))+theme_classic(base_size=24)+theme(axis.text.x=element_text(angle=45,hjust=1))+ggtitle(paste("Treatment =",input$treat,sep=" "))}) %>% shiny::bindEvent(input$go2)
    }
  )
}


## To be copied in the UI
# mod_plotTreat_ui("plotTreat_1")

## To be copied in the server
# mod_plotTreat_server("plotTreat_1")
