
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
    topo_word <- file.path(package = "adveqmap","data","word_map.rds")
    .e$WORD_MAP <- readRDS(topo_word)
  }
  .e$WORD_MAP
}
