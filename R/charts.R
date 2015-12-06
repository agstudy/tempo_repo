




#' Plot bar chart plot by underlying for a location
#'
#' @param dat data set
#' @param country  character country name
#'
#' @import rCharts
#' @return ndv3 plot discretBarChart
#' @export
multiple_barplot <- function (dat=load_data(),country,id_dom="investChart") {
  
  a <- hPlot(multiple~under, 
             data = dat[loc_name==country,
                        list(multiple=round(sum(value*part)/sum(cost*part),2)),
                        under], 
             type = "column",
             group="under",
             title = "Investment vs Underlyings", 
             subtitle = country)
  style <- adveqmap_options("style_list")
  dlabels <- adveqmap_options("data_labels_theme")
  axis_labels <- adveqmap_options("axis_labels_theme")
  dlabels$style <- style
  axis_labels$style <- style 
  a$plotOptions(column = list(dataLabels = dlabels))
  a$xAxis(labels = axis_labels,replace = FALSE)
  
  #  a$params$width <- 400
  a$set(dom = id_dom)
  a
}