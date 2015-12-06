library(shinydashboard)
library(leaflet)
library(shiny)
library(rCharts)

main_title <- 'Adveq Investment Distribution'

logo_row <- 
  fluidRow(
    column( # logo
      width = 4, 
      img(src = 'Adveq_Logo_300dpi_CMYK.jpg', 
          width ='195', 
          height ='61',
          title = 'Adveq',
          alt = 'Adveq')
    ),
    column( # title
      width = 8, 
      h2(main_title)
    )
  )


left_side <-
  column(width = 8,
         box(width = NULL, solidHeader = TRUE,
             leafletOutput("investmap", height = 500)
         ),
         box(width = NULL,solidHeader = TRUE,
             uiOutput("investTable")
         )
  )



var_select <-
  column(width = 6,
         selectInput("variable", "Variable",
                     choices = c(
                       "multiple" = "multiple",
                       "fmv" = "fmv"
                     ),selected = "multiple"))

currency_select <- 
  column(width = 6,
         conditionalPanel(
           condition = "input.variable == 'fmv'",
           selectInput("currency", "Currency",
                       choices = c(
                         "EUR" = "EUR",
                         "USD" = "USD"
                       ))))

chart_region <- 
  div(showOutput("investChart", "Highcharts")
    , class = "span4")



right_side <- 
  column(width = 4,
         var_select,
         currency_select,
         chart_region
  )



main_row <-
  fluidRow(left_side,right_side)



shinyUI(fluidPage(logo_row,main_row))

