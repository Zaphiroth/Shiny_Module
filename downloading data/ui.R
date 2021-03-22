shinyUI(
  fluidPage(
    
    titlePanel("Downloading Data"),
    
    sidebarLayout(
      
      sidebarPanel(
        
        selectInput("dataset", "Choose a dataset:",
                    choices = c("rock", "pressure", "cars", "iris")),
        
        downloadButton("downloadData", "Download")                      ## downloadLink()
        
      ),
      
      mainPanel(
        
        tableOutput("table")
        
      )
      
    )
    
  )
)