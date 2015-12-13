



#' Create InvestMap class
#'
#' \code{InvestMap} S3 class repensents data used of to create a amp of investments
#' @param ratios data.table containing values to show
#' @param criteria character can be multiple or fmv 
#' @param currency character EUR/USD
#'
#' @return An object of class \code{InvestMap}
#' @export
#' @examples
#' InvestMap()
InvestMap <- function(ratios = get_ratios(),criteria="multiple",currency=NULL,topo_word){
  
  legend_title <- legend_title(criteria,currency)
  ratios$indicator <- get_values(ratios,criteria,currency)
  countries <- word_map(topo_word)
  countries@data <- merge(countries,ratios,by.x="name",
                          by.y="loc_name",all.x=TRUE)
  structure(
    list(
      data=countries,
      pal=get_pal(countries$indicator),
      criteria=criteria,
      currency=currency,
      ratios=ratios,
      legend_title=legend_title),
    class="InvestMap")
  
}

#' Plot investment map
#'
#' @param x InvestMap object
#' @method plot InvestMap
#' @export
#' @examples 
#' inMap <- InvestMap()
#' plot(inMap)
plot.InvestMap <- function(x){
  
  map <- leaflet(x$data) %>% 
    addTiles(
      urlTemplate = adveqmap_options("url_template"),
      attribution = ''
    )
  qpal <- x$pal
  map %>% addPolygons(
    layerId=~name,
    stroke = TRUE,  
    fillOpacity = 0.7,
    color=adveqmap_options("polygon_color"),
    fillColor = ~qpal(indicator))%>%
    addLegend(pal = qpal, 
              values = ~indicator, 
              opacity = 1,
              position="bottomleft",
              title=x$legend_title)
}



get_fill_color <- 
  function(investmap,country){
    investmap$pal(investmap$data[investmap$data$name==country,]$indicator)
  }


#' Add polygon to an invest map
#'
#' @param map 
#' @param investmap 
#' @param country 
#' @param highlight 
#'
#' @return invest map 
#' @export

add_polygon <- 
  function(map,investmap,country,highlight){
    map %>% addPolygons(
      data=investmap$data[investmap$data$name==country,],
      layerId=~name,
      stroke = TRUE,  
      fillOpacity = 0.7,
      color=ifelse(highlight,"blue",adveqmap_options("polygon_color")),
      fillColor = get_fill_color(investmap,country),
      weight=ifelse(highlight, 4, 1))
  }


