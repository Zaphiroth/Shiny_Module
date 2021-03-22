
suppressPackageStartupMessages({
  library(shiny)
  library(stats)
  library(ggplot2)
  library(MASS)
  library(mgcv)
  library(dplyr)
  library(plyr)
})

options(shiny.maxRequestSize = 100 * 1024 ^ 2)

shinyServer(
  function(input, output) {
    
    dataset <- reactive({
      
      req(input$file)
      
      d <- read.csv(input$file$datapath, header = input$header) %>%
        unique()
      
    })

    output$nrows <- reactive({
      nrow(dataset)
    })
    
    output$summary <- renderPrint({
      summary(dataset())
    })
    
    output$call <- renderPrint({
      
      req(input$fit)
      
      cn <- colnames(dataset())
      
      formula1 <- as.formula(paste(cn[1], "~", paste(cn[2:length(cn)], collapse = "+")))
      
      if(input$smoothMethod == "Linear regression models") {
        r <- lm(formula1, dataset())
      }
      else if(input$smoothMethod == "Generalized linear regression models") {
        r <- glm(formula1, data = dataset(), family = gaussian)
      }
      else if(input$smoothMethod == "Local polynomial regression models") {
        r <- loess(formula1, dataset())
      }
      else if(input$smoothMethod == "Robust linear regression models") {
        r <- rlm(formula = formula1, data = dataset())
      }
      
      f <- as.formula(paste("formula1: ", cn[1], "~", paste(cn[2:length(cn)], collapse = "+")))
      print(f)
      
      summary(r)
      
    })
    
    output$plot <- renderPlot({
      
      method1 <- switch(input$smoothMethod,
                       "Linear regression models" = lm,
                       "Generalized linear regression models" = glm,
                       "Local polynomial regression models" = loess,
                       "Robust linear regression models" = rlm)
      
      if(input$size == "h") {n = 100}
      else if(input$size == "t") {n = 1000}
      else {n = nrow(dataset())}
      
      if(ncol(dataset()) == 2) {
        
        p <- ggplot(dataset()[1:n, ],
                    aes(dataset()[1:n, 2], dataset()[1:n, 1])) +
          geom_point() +
          labs(x = colnames(dataset())[2], y = colnames(dataset())[1]) +
          theme(axis.title = element_text(size = 15),
                axis.title.x = element_text(hjust = 1),
                axis.title.y = element_text(hjust = 1))
        
        if(input$fit == TRUE) {
          
          p <- p + geom_smooth(method = method1, color = "indianred")
          
        }

      }

      return(p)
      
    })

  }
)