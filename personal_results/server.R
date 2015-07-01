library(shiny)
  
library(ggplot2)
library(rCharts)

options(RCHART_WIDTH = 500,
        RCHART_HEIGHT= 400)

shinyServer(function(input, output) {
#   output$inSelect <- renderUI({ })
  
#   dataInput <- reactive({  
#     p <- filter(results,name==input$person)
#     return(p)
#   })
  
  output$myChart <- renderChart({      
    mytooltip <- paste("#!function(item) {return 'Official time was ' + item.time +
      ' placing ' + item.place}","!#",sep="")
#     mytooltip <- "#!function(item){return 'Time: ' + item.time}!#"
    othertooltip <- paste("#!function(item) {return item.Name + ' finished ' + item.place + 
      ' with a time of ' + item.time}","!#",sep="")

    year <- unique(as.character(select(filter(results,Name==input$person),year=Graduation.Year)$year))
    r1 <- rPlot(Minutes ~ Year, 
            data = filter(results,Name!=input$person), 
            type = "point", 
            color = list(const='#ffff00'),
            opacity=list(const=0.3),
            tooltip = othertooltip)
    r1$layer(y='Minutes', 
         data=filter(results,Name==input$person),
         copy_layer=T, 
         type='point', 
         opacity=list(const=1.0),
         color=list(const='#228b22'),
         tooltip = mytooltip)
    r1$guides(x=list(title="Year",
                 min=(min(results$Year)-1),
                 max=(max(results$Year)+1),
                 ticks=seq(min(results$Year)-1,max(results$Year)+1,1),
                 formatter = "#!function(d){return Number(d).toPrecision(4)}!#"))
    r1$guides(y=list(title="Race Time (minutes)",
                 min=(min(results$Minutes)-0.5),
                 max=(max(results$Minutes)+0.5)))
    mytitle <- paste("Race Results for ",input$person," (Class of ",year,")",sep="")
#     r1$set(title=mytitle,dom = 'myChart')
    r1$set(title=mytitle,dom = 'myChart')

    return(r1)
  })
  
  
})