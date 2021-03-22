shinyUI(
  fluidPage(
    
    titlePanel("Tabsets"),
    
    sidebarLayout(
      
      sidebarPanel(
        
        radioButtons("dist", "Distribution type:",
                     c("Normal" = "norm",
                       "Uniform" = "unif",
                       "Log-normal" = "lnorm",
                       "Exponential" = "exp")),
        
        br(),
        
        sliderInput("n",
                    "Number of observations:",
                    value = 5000,
                    min = 0,
                    max = 10000)
      ),
      
      mainPanel(
        
        tabsetPanel(type = "tabs",
                    tabPanel("Plot", plotOutput("plot")),
                    tabPanel("Summary", verbatimTextOutput("summary")),
                    tabPanel("Table", tableOutput("table")))
      )
    )
  )
)