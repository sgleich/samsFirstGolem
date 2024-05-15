#' runNMDS UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_runNMDS_ui <- function(id){
  ns <- NS(id)
  shiny::tagList(
    shiny::selectInput(ns("date"), "Select Date:", choices = c("All","2021-08-11","2021-08-20","2021-08-27","2021-09-03","2021-09-07","2021-09-08")),
    shiny::actionButton(ns("go3"),"Plot"),
    shiny::plotOutput(ns("plot3"),height = "600px", width = "800px")
  )
}


#' runNMDS Server Functions
#'
#' @noRd
mod_runNMDS_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    df <- periData
    df$Taxon <- NULL
    df$Group <- NULL
    dfMelt <- reshape2::melt(df,id.vars="Feature.ID")
    colsDate <- reshape2::colsplit(dfMelt$variable,"\\.",c("Treatment","Rep","Month","Day"))
    dfMelt$Treatment <- colsDate$Treatment
    dfMelt$Date <- paste(colsDate$Month,colsDate$Day,"2021",sep="-")
    dfMelt$Date <- lubridate::mdy(dfMelt$Date)
    dfMelt$variable <- NULL
    dfMeltMean <- dfMelt %>% group_by(Treatment,Date,Feature.ID) %>% summarize(m=mean(value)) %>% as.data.frame()
    dfMeltMean$New <- paste(dfMeltMean$Treatment,dfMeltMean$Date,sep="_")
    dfMeltMean <- dfMeltMean %>% pivot_wider(id_cols=c("Date","Treatment"),names_from = "Feature.ID", values_from = "m") %>% as.data.frame()
    dfMeltMean$Date <- as.character(dfMeltMean$Date)
    output$plot3 <- shiny::renderPlot({
      if(input$date !="All"){
        dfSub <- subset(dfMeltMean,Date==input$date)
        rownames(dfSub) <- dfSub$Treatment
        dfSub$Date <- NULL
        dfSub$Treatment <- NULL

        dfBray <- vegan::vegdist(dfSub,"bray")
        nmdsOut <- vegan::metaMDS(dfBray,distance="bray",k=2)
        nmdsData <- data.frame(nmdsOut$points)
        nmdsData$Treatment <- ifelse(grepl("^C",rownames(nmdsData)),"Control",NA)
        nmdsData$Treatment <- ifelse(grepl("^N",rownames(nmdsData)),"+N",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^NP",rownames(nmdsData)),"+N+P",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^NPF",rownames(nmdsData)),"+N+P+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^NF",rownames(nmdsData)),"+N+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^F",rownames(nmdsData)),"+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^P",rownames(nmdsData)),"+P",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^PF",rownames(nmdsData)),"+P+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("Tote",rownames(nmdsData)),"T0",nmdsData$Treatment)
        nmdsData$Treatment <- factor(nmdsData$Treatment,levels=c("Control","+N","+N+P","+N+Fe","+N+P+Fe","+P","+Fe","+P+Fe"))
        nmdsData %>% ggplot2::ggplot(aes(x=MDS1,y=MDS2,fill=Treatment))+geom_point(shape=21,size=5)+scale_fill_manual(name="Treatment",values=c("grey","indianred","red","maroon","pink","dodgerblue","blue","navy"))+theme_classic(base_size=18)+geom_hline(yintercept=0,linetype="dotted")+geom_vline(xintercept=0,linetype="dotted")+xlab("NMDS1")+ylab("NMDS2")+ggtitle(paste("Date = ", input$date,sep=" "))}
      else{
        dfSub <- dfMeltMean
        rownames(dfSub) <- paste(dfSub$Treatment,dfSub$Date,sep="_")
        dfSub$Date <- NULL
        dfSub$Treatment <- NULL
        dfBray <- vegan::vegdist(dfSub,"bray")
        nmdsOut <- vegan::metaMDS(dfBray,distance="bray",k=2)
        nmdsData <- data.frame(nmdsOut$points)
        nmdsData$Treatment <- ifelse(grepl("^C_",rownames(nmdsData)),"Control",NA)
        nmdsData$Treatment <- ifelse(grepl("^N_",rownames(nmdsData)),"+N",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^NP_",rownames(nmdsData)),"+N+P",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^NPF_",rownames(nmdsData)),"+N+P+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^NF_",rownames(nmdsData)),"+N+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^F_",rownames(nmdsData)),"+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^P_",rownames(nmdsData)),"+P",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("^PF_",rownames(nmdsData)),"+P+Fe",nmdsData$Treatment)
        nmdsData$Treatment <- ifelse(grepl("Tote",rownames(nmdsData)),"T0",nmdsData$Treatment)
        nmdsData$Treatment <- factor(nmdsData$Treatment,levels=c("T0","Control","+N","+N+P","+N+Fe","+N+P+Fe","+P","+Fe","+P+Fe"))

        nmdsData$Date <- ifelse(grepl("08-09",rownames(nmdsData)),"2021-08-09",NA)
        nmdsData$Date <- ifelse(grepl("08-11",rownames(nmdsData)),"2021-08-11",nmdsData$Date)
        nmdsData$Date <- ifelse(grepl("08-20",rownames(nmdsData)),"2021-08-20",nmdsData$Date)
        nmdsData$Date <- ifelse(grepl("08-27",rownames(nmdsData)),"2021-08-27",nmdsData$Date)
        nmdsData$Date <- ifelse(grepl("09-03",rownames(nmdsData)),"2021-09-03",nmdsData$Date)
        nmdsData$Date <- ifelse(grepl("09-07",rownames(nmdsData)),"2021-09-07",nmdsData$Date)
        nmdsData$Date <- ifelse(grepl("09-08",rownames(nmdsData)),"2021-09-08",nmdsData$Date)
        nmdsData$Date <- factor(nmdsData$Date,levels=c("2021-08-09","2021-08-11","2021-08-20","2021-08-27","2021-09-03","2021-09-07","2021-09-08"))
        nmdsData %>% filter(Date!="2021-09-08") %>% ggplot2::ggplot(aes(x=MDS1,y=MDS2,fill=Treatment,shape=Date))+geom_point(size=5)+scale_shape_manual(name="Date",values=c(8,21,22,23,24,25))+scale_fill_manual(name="Treatment",values=c("black","grey","indianred","red","maroon","pink","dodgerblue","blue","navy"))+theme_classic(base_size=18)+guides(fill = guide_legend(override.aes = list(shape=21)))+geom_hline(yintercept=0,linetype="dotted")+geom_vline(xintercept=0,linetype="dotted")+xlab("NMDS1")+ylab("NMDS2")+ggtitle("All Dates")}
      }) %>% shiny::bindEvent(input$go3)}
  )
  }




## To be copied in the UI
# mod_runNMDS_ui("runNMDS_1")

## To be copied in the server
# mod_runNMDS_server("runNMDS_1")
