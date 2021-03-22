shinyServer(
  
  function(input, output) {
    
    datasetInput <- eventReactive(input$update, {
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars)
    }, ignoreNULL = FALSE)
    
    output$summary <- renderPrint({
      summary(datasetInput())
    })
    
    output$view <- renderTable({
      head(datasetInput(), n = isolate(input$obs))
    })
    
  }
  
)