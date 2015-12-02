

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
get_ratios <- 
  function(db=load_data(...),...){
    fx <- get_fx(db)
    db[,list(multiple=sum(value)/sum(cost)),"loc_name,date"]
    
    
  }