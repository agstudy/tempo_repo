
#' @import settings
.onLoad <- function(libname , pkgname) {
  layer_path <- system.file(package = "adveqmap","data","countries.geojson")
  .e$COUNTRIES <- readOGR(layer_path, "OGRGeoJSON")
}

