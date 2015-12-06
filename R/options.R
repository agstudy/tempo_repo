#' @import settings
.options <- 
  settings::options_manager(
      pal = c('#FFEDA0','#FEB24C','#FC4E2A' ,'#BD0026'  ),
      polygon_color = "white",
      url_tile = "http://server.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}",
      style_list = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'),
      data_labels_theme =  list(enabled = TRUE, rotation=-90,
                                align = 'center', color = '#FFFFFF', 
                                x = 4, y = 15),
      axis_labels_theme = list(rotation = -45, 
                               align = 'right') 
    )
  

.e <- new.env()

#' Set or get options for my adveqmap package
#' 
#' @param ... Option names to retrieve option values or \code{[key]=[value]} pairs to set options.
#'
#' @section Supported options:
#' The following options are supported
#' \itemize{
#'  \item{\code{pal}}{(\code{list};2) The map palette }
#'  \item{\code{polygon_color}}{(\code{characater};"white") The value of polygon side color }
#'  \item{\code{url_tile}}{(\code{characater};"white") The value of url tile }
#'  \item{\code{style_list}}{(\code{characater};) The value of multibar plot font style }
#'  \item{\code{data_labels_theme}}{(\code{list};) multibar text settings}
#'  \item{\code{axis_labels_theme}}{(\code{list};) multibar axis settings}
#' }
#' @import settings
#' @export
adveqmap_options <- function(...){
  # protect against the use of reserved words.
  stop_if_reserved(...)
  .options(...)
}


#' Reset global options for pkg
#'
#' @export
adveqmap_reset <- function()reset(.options)