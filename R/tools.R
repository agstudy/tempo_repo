.e <- new.env()

.e$colors <- c('#800026' ,'#BD0026' ,'#E31A1C' ,
            '#FC4E2A' ,'#FD8D3C' ,'#FEB24C' ,
            '#FED976' ,'#FFEDA0')

.e$pal <- rev(.e$colors[c(1,3,5,7)])
.e$polygon_color <- "white"

.e$url_tile <- "http://server.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}"


