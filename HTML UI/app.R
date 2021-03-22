library(shiny)

server <-
  function(input, output) {
    
    data <- reactive({
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
      
      hist(data(),
           main = paste("r", dist, "(", n, ")", sep = ""),
           col = "indianred", border = "white")
      
    })
    
    output$summary <- renderPrint({
      summary(data())
    })
    
    output$table <- renderTable({
      data.frame(x = data())
    })
    
  }

shinyApp(ui = htmlTemplate("index.html"), server)