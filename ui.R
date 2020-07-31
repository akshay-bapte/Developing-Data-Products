library(shiny)
library(plotly)

fpl <- read.csv("FPL_2018_19_Wk0.csv") 

shinyUI(fluidPage(

    # Application title
    titlePanel("Fantasy Premier League 2018-19"),

    sidebarLayout(
        sidebarPanel(
            
            selectInput("team", 
                        "Select team of the player", 
                        paste(fpl$Team),
                        selected = 1),
        
          
            radioButtons("position", "Select position of the player",
                         choices = unique(fpl$Position), selected = unique(fpl$Position)[1])),

        
        mainPanel(
            tabsetPanel(type = "tabs",
        tabPanel("Plot", plotlyOutput('plot')),        
        tabPanel("Table", dataTableOutput('table'))
        )
    )
)
)
)