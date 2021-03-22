shinyServer(
  function(input, output) {
    
    datasetInput <- reactive({
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars,
             "iris" = iris)
    })
    
    output$table <- renderTable({
      datasetInput()
    })
    
    output$downloadData <- downloadHandler(
      filename = function() {
        paste(input$dataset, ".csv", sep = "")
      },
      content = function(file) {
        write.csv(datasetInput, file, row.names = FALSE)
      }
    )
    
  }
)