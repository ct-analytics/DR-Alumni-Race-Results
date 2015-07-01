library(shiny)
require(rCharts)
# options(RCHART_LIB = 'polycharts')
shinyUI(fluidPage(
  verticalLayout(
    titlePanel("DR Alumni Race Results"),
    wellPanel(selectInput("person", 
                 label = h4("Select a Runner"), 
                 choices = names,
                 selected = "Adam Hart")),
    showOutput("myChart","polycharts")
)))