
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(adveqmap)
db <- load_data()

shinyServer(function(input, output) {
  vals <- reactiveValues(country=NULL)
  ratios <- reactive(get_ratios(db = db))
  output$investmap <- renderLeaflet({
    if(is.null(input$variable))return()
    plot_map(ratios = ratios() , 
             criteria = input$variable, 
             currency = input$currency)
  })
  
 
  

  showCountryPopup <- function(country, lat, lng) {
    
    content = popup_content(country ,ratios()[loc_name==country,nbr])
    leafletProxy("investmap") %>% addPopups(lng, lat, content, layerId = country)
  }
  
  output$investChart <- renderChart2({
    if(is.null(vals$country))return()
    multiple_barplot(db,vals$country,id="investChart")
  })
  
  
  # When map is clicked, show a popup with city info
  observe({
    leafletProxy("investmap") %>% clearPopups()
    event <- input$investmap_shape_click
    if (is.null(event))
      return()
    
    isolate({
      vals$country <- event$id 
      showCountryPopup(event$id, event$lat, event$lng)
    })
  })
  
})
