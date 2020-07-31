#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)


shinyServer(function(input, output) {
    
    fpl <- read.csv("FPL_2018_19_Wk0.csv") 
    fpl_sub <- reactive({
        fpl %>%
            select(1,2,3,21,10,11) %>%
            filter(fpl$Team == input$team, fpl$Position == input$position) 
            })
    figure <- reactive({plot_ly(fpl_sub(), x = ~Goals_scored, y = ~Assists, text = ~Points, type = 'scatter', mode = 'markers', size = ~Points, color = ~Name, colors = 'Paired',
                      marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
        layout(title = "Goals, Assists and Points by each player")
        })
    
    output$table <- renderDataTable(
        fpl_sub()
    )
    output$plot <- renderPlotly(
        figure()
    )

})
