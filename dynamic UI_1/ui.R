library(shiny)

shinyUI(
  pageWithSidebar(
    
    headerPanel("Dynamic UI"),
    
    sidebarPanel(
      
      checkboxInput("smooth", "Smooth"),
      
      conditionalPanel(
        
        condition = "input.smooth == true",
        
        selectInput("smoothMethod", "Method",
                    c("lm", "glm", "gam", "loess", "rlm"))
        
      ),
      
      selectInput("dataset", "Dataset", c("rock", "pressure", "cars")),
      
      conditionalPanel(
        
        condition = "output.nrows",
        
        checkboxInput("headonly", "Only use first 100 rows")
        
      )
      
    ),
    
    mainPanel(
      
      h3("Fitted curve"),
      
      plotOutput("plot")
      
    )
    
  )
)