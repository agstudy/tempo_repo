library(shinydashboard)
library(leaflet)
library(shiny)



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
  column(width = 9,
         box(width = NULL, solidHeader = TRUE,
             leafletOutput("investmap", height = 500)
         ),
         box(width = NULL,
             uiOutput("investTable")
         )
  )

right_side <- 
  column(width = 3,
         box(width = NULL, status = "warning",
             selectInput("variable", "Variable",
                         choices = c(
                           "multiple" = "multiple",
                           "fmv" = "fmv"
                         ),selected = "multiple"),
             conditionalPanel(
               condition = "input.variable == 'fmv'",
               selectInput("currency", "Currency",
                           choices = c(
                             "EUR" = "EUR",
                             "USD" = "USD"
                           ))),
             uiOutput("investChart")
         )
  )


main_row <-
  fluidRow(left_side,right_side)



shinyUI(fluidPage(logo_row,main_row))

