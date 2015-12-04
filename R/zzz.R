

.onLoad <- function(libname , pkgname) {
layer_path <- system.file(package = "adveqmap","data","countries.geojson")
.e$countries <- readOGR(layer_path, "OGRGeoJSON")
}

