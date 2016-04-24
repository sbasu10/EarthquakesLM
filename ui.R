library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("EARTHQUAKES LM"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    selectInput("selectedResponse", label = h3("Select the response column"), 
                c(dfnames), selected = 'Magnitude'),    
    hr(),
    
    checkboxGroupInput("predictorTerms", 
                       label = h3("Select one or more columns as the terms for linear predictor"), 
                       choices = c(dfnames),
                       selected = c('Depth', 'NST'))
    ),
    mainPanel(
      verbatimTextOutput("header"),
      plotOutput("multiPlots"),
      verbatimTextOutput("regTab"),
      verbatimTextOutput("anovaTab"),
      dataTableOutput('RawData')
    )
))

