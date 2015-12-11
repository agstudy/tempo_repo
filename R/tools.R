
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
           bin =length(adveqmap_options("pal")),
           na.color = adveqmap_options("missing_color"))           
}

#' @importFrom rgdal readOGR
#' @importFrom  rgdal ogrListLayers
word_map <- function(){
  if(is.null(.e$WORD_MAP)){
    topo_word <- system.file(package = "adveqmap","data","countries.topojson")
    my_layer <- ogrListLayers(topo_word)
    word_map <- readOGR(topo_word, layer = my_layer[1],
                        drop_unsupported_fields = TRUE)
    .e$WORD_MAP <- word_map[order(word_map$name),]
  }
  .e$WORD_MAP
}