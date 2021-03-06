
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rCharts)
library(adveqmap)
library(leaflet)
db <- load_data(path=file.path(".","data","database.csv"))
word_path <- file.path(".","data","word_map.rds")
shinyServer(function(input, output) {
  values <- reactiveValues(highlight=c())
  ratios <- reactive(get_ratios(db = db))
  invest_map <- reactive( {
    if (!file.exists(word_path))return()
      InvestMap(ratios = ratios() , 
              criteria = input$variable, 
              currency = input$currency,
              topo_word=word_path)
  }
  )
  output$investmap <- renderLeaflet({
    if(is.null(input$variable))return()
    plot(invest_map()) %>%
           setView(10.804851,37.954540,zoom=2)
  })
  
  
  
  
  showCountryPopup <- function(country, lat, lng) {
    content = popup_content(country ,ratios()[loc_name==country,nbr])
    leafletProxy("investmap") %>% addPopups(lng, lat, content, layerId = country)
  }
  
  observe({
    values$highlight <- input$investmap_shape_mouseover$id
  })
  
  observe({
    if(!is.null(values$highlight))
      output[["investChart"]] <- 
        renderChart2(multiple_barplot(db,values$highlight,id="investChart"))
  })
  
  
  lastHighlighted <- c()
  
  # When map is clicked, show a popup with city info
  observe({
    if (length(lastHighlighted) > 0){
      isolate(
        leafletProxy("investmap") %>% 
          add_polygon(invest_map(),lastHighlighted,FALSE)
      )
    }
    lastHighlighted <<- values$highlight
    
    if (is.null(values$highlight))
      return()
    
    isolate({
      leafletProxy("investmap") %>% 
        add_polygon(invest_map(),values$highlight,TRUE)
    })
  })
  
  # Draw the given states, with or without highlighting
  
})
