shinyServer(
  function(input, output) {
    
    d <- reactive({
      dist <- switch(input$dist,
                     norm = rnorm,
                     unif = runif,
                     lnorm = rlnorm,
                     exp = rexp,
                     rnorm)
      dist(input$n)
    })
    
    output$plot <- renderPlot({
      dist <- input$dist
      n <- input$n
      
      hist(d(),
           main = paste("r", dist, "(", n, ")", sep = ""),
           col = "indianred", border = "white")
    })
    
    output$summary <- renderPrint({
      summary(d())
    })
    
    output$table <- renderTable({
      d()
    })
  }
)