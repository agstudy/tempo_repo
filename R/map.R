




#' Plot investment map
#'
#' @return map
#' @export
#' @import rgeos
#' @import leaflet
#' @import rgdal
#'
plot_map <- function(){
  create_popups <- 
    function(result){
      paste(
        paste0(
          "<b>",result[,"loc_name"],"</b><br/>",
          "<b>",as.character(result[,"nbr"])," Companies </b>"
        )
      )
    }
 
#   function getColor(d) {
#     return d > 1000 ? '#800026' :
#       d > 500  ? '#BD0026' :
#       d > 200  ? '#E31A1C' :
#       d > 100  ? '#FC4E2A' :
#       d > 50   ? '#FD8D3C' :
#       d > 20   ? '#FEB24C' :
#       d > 10   ? '#FED976' :
#       '#FFEDA0';
#   }
  # From http://data.okfn.org/data/datasets/geo-boundaries-world-110m
  rr <- get_ratios()
  countries <- readOGR("inst/data/countries.geojson", "OGRGeoJSON")
  fcountries <- countries[countries$admin %in% rr$loc_name,]
  fcountries <- fcountries[order(fcountries$admin),]
  dd <- merge(rr,countries@data,by.x="loc_name",by.y="admin")
  fcountries@data <- dd[order(dd$loc_name),]
#   shapes_centers <- gCentroid(fcountries,byid=TRUE)
#   result <- as.data.frame(cbind(shapes_centers@coords,fcountries@data))
  map <- leaflet(fcountries) %>% 
         addTiles(urlTemplate="http://{s}.tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png")
  qpal <- colorQuantile("Reds", countries$multiple, n =4)
  map %>% addPolygons(
    stroke = TRUE,  
                fillOpacity = 0.7,
                dashArray= '3',
                color="white",
                fillColor = ~qpal(multiple),
    popup=create_popups(as.data.frame(dd))) %>% 
  addLegend(pal = qpal, values = ~multiple, opacity = 1) 
#   addMarkers(lng=result[,"x"], 
#                lat=result[,"y"],
#                popup=create_popups(result)) 
}
