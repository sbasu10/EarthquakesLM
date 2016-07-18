
shinyServer(function(input, output) {
  
  runRegression <- reactive({
    frmlObj <- as.formula(paste(input$selectedResponse," ~ ",paste(input$predictorTerms,collapse="+")))
    lm(frmlObj,data=df,model=TRUE)
  })
  
  output$multiPlots <- renderPlot({
    y <- input$selectedResponse
    lmObject <- runRegression()
    
    par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
    plot(lmObject, id.n = 5, labels.id = NULL)  # 5 id numbers
  })
  
  output$header <- renderPrint({
    if(!is.null(input$predictorTerms)){
      print("Formula (frmlObj): ")
      frmlObj <- as.formula(paste(input$selectedResponse," ~ ",paste(input$predictorTerms,collapse="+")))
      print(frmlObj, showEnv=FALSE)
    } else {
      print(data.frame(Warning="Please select columns that can be used as features in the linear regression model"))
    }
  })
  
  output$regTab <- renderPrint({
    if(!is.null(input$predictorTerms)){
      lmObject <- runRegression()
      summary.lm(lmObject, correlation=TRUE, digits=5, signif.stars=TRUE)
    } else {
      print(data.frame(Warning="Please select columns that can be used as features in the linear regression model"))
    }
  })

  output$anovaTab <- renderPrint({
    if(!is.null(input$predictorTerms)){
      anovaObject <- anova(runRegression())
      print(anovaObject)
    } else {
      print(data.frame(Warning="Please select columns that can be used as features in the linear regression model"))
    }
  })
  
  output$RawData <- renderDataTable({
    df
  })
  

})


