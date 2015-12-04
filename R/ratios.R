

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
#' @param level charcater level of aggregation. It can be 
#' \itemize{
#' \item{country}
#' \item{region}
#' \item{subregion}
#' }
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
  function(db=load_data(...),level,...){
    
    if(missing(level)) level <- "country"
    fx <- get_fx(db)
    key <- switch (level,
           "region"="region,date",
           "subregion"="subregion,date",
           "loc_name,date")
           
    db[,list(
      multiple=
               sum(value*part*fx[date==date,toEUR])/
        sum(cost*part*fx[date==date,toEUR]),
      nbr =length(unique(company))),key]
  }


