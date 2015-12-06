




#' Plot bar chart plot by underlying for a location
#'
#' @param dat data set
#' @param country  character country name
#'
#' @import rCharts
#' @return ndv3 plot discretBarChart
#' @export
multiple_barplot <- function (dat=load_data(),country,id_dom) {
#   p2 <- nPlot( multiple~under, 
#                data = dat[loc_name==country,
#                           list(multiple=sum(value*part)/sum(cost*part)),under], 
#                type = 'discreteBarChart'
#   )
#   #p2$chart(color = c('brown', 'blue', '#594c26', 'green'))
#   p2
  
  
  a <- hPlot(multiple~under, 
             data = dat[loc_name==country,
                        list(multiple=round(sum(value*part)/sum(cost*part),2)),
                        under], 
             type = 'column',
             group="under")
  a$plotOptions(column = list(dataLabels = list(enabled = TRUE, 
                                                align = 'center', color = '#FFFFFF', x = 4, y = 15, 
                                                style = list(fontSize = '13px', fontFamily = 'Verdana, sans-serif'))))
  a$xAxis(labels = list(rotation = -45, 
                        align = 'right', 
                        style = list(fontSize = '13px', 
                                     fontFamily = 'Verdana, sans-serif')), 
          replace = FALSE)
  
#  a$params$width <- 400
  a$set(dom = id_dom)
  a
}