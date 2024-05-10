#' subsetTax
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

subsetTax <- function(data,tax){
  set.seed(100)
  data$Feature.ID <- NULL
  if(tax=="Whole Community"){data$Taxon <- data$Group}
  data$Group <- NULL
  meltSubsD <- reshape2::melt(data,id.vars=c("Taxon"))
  taxSubs <- reshape2::colsplit(meltSubsD$Taxon,";",c("d","k","p","c","o","f","g","sp"))

  if(tax=="Whole Community"){meltSubsD$taxFin <- taxSubs$d}
  if(tax=="Diatom"){meltSubsD$taxFin <- taxSubs$f}
  if(tax=="Dinoflagellate"){meltSubsD$taxFin <- taxSubs$o}
  if(tax=="Haptophyte"){meltSubsD$taxFin <- taxSubs$o}
  if(tax=="Chlorophyte"){meltSubsD$taxFin <- taxSubs$o}
  if(tax=="Ciliate"){meltSubsD$taxFin <- taxSubs$o}
  if(tax=="Other Eukaryote"){meltSubsD$taxFin <- taxSubs$p}
  if(tax=="Metazoa"){meltSubsD$taxFin <- taxSubs$c}
  meltSubsD$taxFin <- ifelse(meltSubsD$taxFin=="Eukaryota_XX","Unknown",meltSubsD$taxFin)
  meltSubsD$taxFin <- ifelse(meltSubsD$taxFin=="","Unknown",meltSubsD$taxFin)
  meltSubsD$taxFin <- stringr::str_remove_all(meltSubsD$taxFin, "_X")
  meltSubsD$Taxon <- NULL
  meltSummed <- meltSubsD %>% group_by(variable,taxFin) %>% summarize(s=sum(value)) %>% as.data.frame()

  colsD <- reshape2::colsplit(meltSummed$variable,"\\.",c("Treatment","Rep","Month","Day"))
  colsD$Date <- paste(colsD$Month,colsD$Day,"2021",sep="-")
  colsD$Date <- lubridate::mdy(colsD$Date)
  colsD$Date <- as.character(colsD$Date)
  meltSummed$Treatment <- colsD$Treatment
  meltSummed$Date <- colsD$Date
  meltSummed$variable <- NULL

  meltMean <- meltSummed %>% group_by(Date,taxFin,Treatment) %>% summarize(m=mean(s)) %>% as.data.frame()

  meltMean$Treatment <- ifelse(meltMean$Treatment=="C","Control",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="N","+N",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="P","+P",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="NP","+N+P",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="NF","+N+Fe",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="PF","+P+Fe",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="NPF","+N+P+Fe",meltMean$Treatment)
  meltMean$Treatment <- ifelse(meltMean$Treatment=="F","+Fe",meltMean$Treatment)

  meltMean$Treatment <- factor(meltMean$Treatment,levels=c("Control","+N","+N+P","+N+Fe","+N+P+Fe","+P","+P+Fe","+Fe"))
  return(meltMean)}
