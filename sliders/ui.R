shinyUI(fluidPage(
  
  titlePanel("Sliders"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput("integer", "Integer:", min = 0, max = 1000, value = 500),
    
      sliderInput("decimal", "Decimal:", min = 0, max = 1, value = 0.5, step = 0.1),
    
      sliderInput("range", "Range:", min = 0, max = 1000, value = c(200, 500)),
    
      sliderInput("format", "Custom Format:", min = 0, max = 10000, value = 0, step = 2500, pre = "$", sep = ",", animate = TRUE),
      
      sliderInput("animation", "Looping Animation:", min = 0, max = 2000, value = 1, step = 10, animate = animationOptions(interval = 10, loop = TRUE))

    ),
    mainPanel(
      
      tableOutput("values")
      
    )
  )
))