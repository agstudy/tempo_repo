
# 
# library(ggmap)
# 
# ##db[,geocode(Geography),Geography]
# 
# library(maps)
# ## mapStates = map("state", fill = TRUE, plot = FALSE)
# mapWord <- map('world', fill = TRUE,plot=FALSE)
# leaflet(data = mapWord) %>% addTiles() %>%
#   addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

#' Load data from Excel
#' 
#' @param path character Excel workbook path
#' @param sheet character sheet name default to RAW
#' @import XLConnect
#' @return data.table containing
#' \itemize{
#' \item{loc_name} {:The location name}
#' \item{loc_id} {:The location id}
#' \item{region} {:The location region id}
#' \item{subregion} {:The location subregion id}
#' \item{fund} {:The fund name}
#' \item{under} {:The underyling name}
#' \item{part} {:The adveq participation}
#' \item{date} {:The date of investment}
#' \item{currency}{: The investment currency}
#' \item{industry} {:The industry sector}
#' \item{value} {:The investment amount}
#' \item{cost} {:The investment cost}
#' }
#' @import data.table
#' @export 
load_data <- 
  function(path,sheet="RAW"){
    if (missing(path))
      path <- system.file(package="adveqmap","data","database.xlsx")
    wb <- loadWorkbook(path)
    db <- readWorksheet(wb, sheet = "RAW")
    
    setDT(db)[,{
      code <- gsub('(^[0-9]+).*','\\1',Geography)
      list(
        loc_name=gsub('^[0-9]+ ','',Geography),
        loc_id=code,
        region=substr(code,1,1),
        subregion=substr(code,1,2),
        fund=Your_Fund,
        under=Fund_Investment,
        company=Company,
        part=Your_Fund_Percent,
        date=as.Date(As_Of_Date,"%d/%m/%Y"),
        industry=Industry,
        currency=YF_Currency,
        value=Total_Value_YF_Cur,
        cost=Total_Cost_YF_Cur)
    }]
  }




#' Get FX rate in USD and EUR
#'
#' @param db 
#'
#' @return data.table of rates
#' @importFrom quantmod getFX
#' @export
#'
get_fx <- function(db){
  unique(db[,list(currency,date)])[,{
    list(
    toEUR=getFX(paste(currency,"EUR",sep="/"),
          from=date,date,  auto.assign = FALSE)[[1]],
    toUSD=getFX(paste(currency,"USD",sep="/"),
          from=date,date,  auto.assign = FALSE)[[1]])
    },
    "date,currency"]
}

#' Compute indicators used by map 
#' 
#' This functions computes indcators like fmv and multiple.
#'
#' @param db  data_base
#' @param ... other parametersused by load_data 
#'
#' @return data.table containing 
#' \itemize{
#' \item {region}
#' \item {subregion}
#' \item {multiple}
#' \item {fmv}
#' }
#' @export
#'
indicators <- 
  function(db=load_data(...),...){
    fx <- get_fx(db)
    db[,list(multiple=sum(value)/sum(cost)),"loc_name,date"]
    
    
  }