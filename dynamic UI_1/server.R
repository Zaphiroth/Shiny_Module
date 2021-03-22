library(shiny)
library(ggplot2)
library(MASS)

shinyServer(
  function(input, output) {
    
    datasetInput <- reactive({
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars)
    })
    
    output$nrows <- reactive({
      nrow(datasetInput())
    })
    
    output$plot <- renderPlot({
      
      if(input$headonly == TRUE) {
        p <- ggplot(datasetInput()[1:100, ],
                    aes(datasetInput()[1:100, ][, 1], datasetInput()[1:100, ][, 2])) + geom_point() +
          labs(x = colnames(datasetInput())[1], y = colnames(datasetInput())[2]) +
          theme(title = element_text(size = 15),
                axis.title.x = element_text(hjust = 1),
                axis.title.y = element_text(hjust = 1))
      }
      else {
        p <- ggplot(datasetInput(),
                    aes(datasetInput()[, 1], datasetInput()[, 2])) + geom_point() +
          labs(x = colnames(datasetInput())[1], y = colnames(datasetInput())[2]) +
          theme(title = element_text(size = 15),
                axis.title.x = element_text(hjust = 1),
                axis.title.y = element_text(hjust = 1))
      }

      if(input$smooth == TRUE) {
        p <- p + geom_smooth(method = input$smoothMethod, color = "indianred")
      }
      
      return(p)
      
    })
    
  }
)