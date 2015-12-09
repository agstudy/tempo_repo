
#' Create popup content
#' 
#' When a map shape is slected a popup can be trigged
#'
#' @param country character country ou region selected
#' @param nbr numeric number of companies
#'
#' @return popup text as character
#' @export
popup_content <- 
  function(country,nbr){
      paste0(
        "<b>",country,"</b><br/>",
        "<b>",nbr," Companies </b>"
    )
  }

legend_title <- 
  function(criteria,currency){
    if(criteria=="multiple")"multiple quantile"
    else ifelse(currency=="EUR","FMV(EUR)","FMV(USD)")
  }

get_values <- 
  function(ratios,criteria,currency){
    if(criteria=="multiple")ratios[,multiple]
    else if(currency=="EUR")ratios[,fmvEUR]
    else ratios[,fmvUSD]
  }


get_pal <- function(values){
  colorBin(adveqmap_options("pal"),range(values,na.rm = TRUE) , 
           bin =length(adveqmap_options("pal")),na.color = "#E6E6E6")           
}



#' Plot investment map
#'
#' @param ratios data.table containing variables to plot
#' @param criteria character 
#' @param currency character
#' @return map
#' @export
#' @import rgeos
#' @import leaflet
#' @import rgdal
#'
plot_map <- function(ratios = get_ratios(),criteria="multiple",currency=NULL){
 
  ratios$indicator <- get_values(ratios,criteria,currency)
  
  # From http://data.okfn.org/data/datasets/geo-boundaries-world-110m
  countries <- .e$COUNTRIES[order(.e$COUNTRIES$admin),]
  countries@data <- merge(countries,ratios,by.x="admin",by.y="loc_name",all.x=TRUE)
  qpal <- get_pal(countries$indicator)
  
  map <- leaflet(countries) %>% 
   addTiles(
    urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
    attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
  )
  
  map %>% addPolygons(
    layerId=~admin,
    stroke = TRUE,  
                fillOpacity = 0.7,
                dashArray= '3',
                color=adveqmap_options("polygon_color"),
                 fillColor = ~qpal(indicator))%>%
  addLegend(pal = qpal, 
            values = ~indicator, 
            opacity = 1,
            position="bottomleft",
            title=legend_title(criteria,currency))
}
