
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(adveqmap)


shinyServer(function(input, output) {

  ratios <- reactive(get_ratios())
  output$investmap <- renderLeaflet({
    if(is.null(input$variable))return()
   plot_map(ratios = ratios() , criteria = input$variable,currency = input$currency)
  })

})
