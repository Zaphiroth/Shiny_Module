options(shiny.maxRequestSize = 100 * 1024 ^ 2)

shinyServer(
  function(input, output) {
    
    output$contents <- renderTable({
      
      req(input$file1)
      
      df <- read.csv(input$file1$datapath,
                     header = input$header,
                     sep = input$sep,
                     quote = input$quote)
      
      if(input$disp == "head") {
        return(head(df))
      }
      else {
        return(df)
      }
      
    })
    
  }
)