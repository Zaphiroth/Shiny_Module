
suppressPackageStartupMessages({
  library(shiny)
  library(stats)
  library(ggplot2)
  library(MASS)
  library(mgcv)
  library(dplyr)
  library(plyr)
})

shinyUI(
  fluidPage(
    
    titlePanel("Regression"),
    
    sidebarLayout(
      
      sidebarPanel(
        
        fileInput("file", "Choose .csv File:",
                  accept = c("text/csv",
                             "text/comma-separated-values, text/plain",
                             ".csv")),
        
        checkboxInput("header", "Header", TRUE),
        
        radioButtons("size", "Sample size:",
                     c("All" = "a",
                       "First 100 rows" = "h",
                       "First 1000 rows" = "t")),
          
        tags$hr(),
        
        checkboxInput("fit", "Fit"),

        conditionalPanel(
          
          condition = "input.fit == true",
          
          selectInput("smoothMethod", "Method",
                      list("Linear regression models",
                           "Generalized linear regression models",
                           "Local polynomial regression models",
                           "Robust linear regression models"))

        ),
        
        tags$hr(),
        
        h4("Note"),
        
        helpText("Please upload data with .csv but without character variables.
                 The first column will become response, and the others will be
                 arguments. While arguments are more than 1, plot will not be
                 rendered.")
        
      ),
      
      mainPanel(
        
        h4("Summary"),
        
        verbatimTextOutput("summary"),
        
        h4("Model"),
        
        verbatimTextOutput("call"),
        
        h4("Plot"),
        
        plotOutput("plot")
        
      )
      
    )
    
  )
)