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
                       label = h3("Select one or more columns as the features for linear regression model"), 
                       choices = c(dfnames),
                       selected = c('Depth', 'NST'))
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Linear Regression Model",
               verbatimTextOutput("header"),
               plotOutput("multiPlots"),
               verbatimTextOutput("regTab"),
               verbatimTextOutput("anovaTab")
      ),
      tabPanel("Dataset",
               dataTableOutput('RawData')
      ),
      tabPanel("Documentation",
               includeHTML("learnMore.html")
      )
    )
  )
  
))

