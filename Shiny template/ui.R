library(shiny)
library(markdown)

main_title <- 'Adveq Shiny Template'







shinyUI(fluidPage(
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
    ),
    sidebarLayout(
        # input tabs on the left
        sidebarPanel(
            tabsetPanel(
                tabPanel(
                    title = 'Inputs 1', 
                    p('Inputs 1 controls')
                ),
                tabPanel(
                    title = 'Inputs 2', 
                    p('Inputs 2 controls')
                ),
                tabPanel(
                    title = 'Inputs 3', 
                    p('Inputs 3 controls')
                ), 
                type = 'tabs'
            ), 
            width = 4
        ),
        
        # output tabs on the right
        mainPanel(
            tabsetPanel(
                tabPanel('Output 1',
                         p('Output 1 results')
                ),
                tabPanel('Output 2',
                         p('Output 2 results')
                ),
                tabPanel('Output 3',
                         p('Output 3 results')
                ),
                tabPanel('Documentation', 
                         includeMarkdown('README.md')),
                type = 'tabs'
            )
        )
    ),
    title = main_title
))
