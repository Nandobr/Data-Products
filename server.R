#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(rpart)
titanicTrain <- read.csv("train.csv",header=TRUE)
titanicTrain$Pclass <- as.factor(titanicTrain$Pclass)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

      model2 <- rpart(Survived ~ Pclass + Sex + Age,
                      data=titanicTrain,
                      method="class")
      
      model1pred <- reactive({
            p<-as.factor(input$class)
            s<-as.factor(input$sex)
            a<-as.numeric(input$age)
            dfnp <- data.frame(Pclass=p,Sex=s,Age=a)
            r<-predict(model2, newdata = dfnp,type = "class") 
            levels(r)[r]
      })

  
  output$pred1 <- renderText({
        model1pred()
  })
  # output$result <- renderText({
  #       ifelse(r=="0","NO, didn't survived !","YES, survived !")
  # })

  output$t1 <- renderText({
        paste("class:",input$class,", sex:",input$sex,", Age:",input$age)
        # input$class
  })

})
