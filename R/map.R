




#' Plot investment map
#'
#' @return map
#' @export
#' @import rgeos
#' @import leaflet
#' @import rgdal
#'
plot_map <- function(ratios = get_ratios(),criteria="multiple",currency="EUR"){
  create_popups <- 
    function(result){
      paste(
        paste0(
          "<b>",result[,"loc_name"],"</b><br/>",
          "<b>",as.character(result[,"nbr"])," Companies </b>"
        )
      )
    }
  
  legend_title <- 
    function(criteria,currency){
      if(criteria=="multiple")"multiple quantile"
      else ifelse(currency=="EUR","FMV(EUR)","FMV(USD)")
    }
  
  get_values <- 
    function(criteria,currency){
      if(criteria=="multiple")ratios[,multiple]
      else if(currency=="EUR")ratios[,fmvEUR]
           else ratios[,fmvUSD]
    }
  
  
  get_pal <- function(values)
    colorQuantile(.e$pal,values , n =length(.e$pal))
  ratios$indicator <- get_values(criteria,currency)
  
  # From http://data.okfn.org/data/datasets/geo-boundaries-world-110m
  countries <- .e$countries
  fcountries <- countries[countries$admin %in% ratios$loc_name,]
  fcountries <- fcountries[order(fcountries$admin),]
  dd <- merge(ratios,countries@data,by.x="loc_name",by.y="admin")
  fcountries@data <- dd[order(dd$loc_name),]
  qpal <- get_pal(fcountries$indicator)
  
  map <- leaflet(fcountries) %>% 
         addTiles(
           urlTemplate=.e$url_tile,
           options = tileOptions(noWrap = TRUE))
  
  map %>% addPolygons(
    stroke = TRUE,  
                fillOpacity = 0.7,
                dashArray= '3',
                color=.e$polygon_color,
                fillColor = ~qpal(indicator),
    popup=create_popups(as.data.frame(dd))) %>% 
  addLegend(pal = qpal, 
            values = ~indicator, 
            opacity = 1,
            position="bottomleft",
            title=legend_title(criteria,currency))
}
