#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Read titanic dataset
# setwd("~/R_coursera/Data Product/titanic")
titanicTrain <- read.csv("train.csv",header=TRUE)
test <- read.csv("test.csv",header=TRUE)
titanicTrain$Pclass <- as.factor(titanicTrain$Pclass)
# remove 2nd collumn : Survived
t <- titanicTrain[,-2]
titdf <-  rbind(test, t)
titdf$Pclass <- as.factor(titdf$Pclass)
titdf$Sex <- as.factor(titdf$Sex)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Titanic Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
          h4("New passenger information:"),
          br(),
          selectInput( "class", "Class", levels(titdf[1,2]), "3"),
          selectInput( "sex", "Sex", levels(titdf[1,4]), "male"),
          sliderInput("age",
                      "Age:",
                      min = 1,
                      max = 80,
                      value = 20)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
          h2("Titanic Shiny aplication"),
          em("This app trains a model(decision tree) to predict if the new passenger will survive."),
          br(),
          em("Please, select the new passenger's characteristics on the side panel."),

          h3("You selected: "),
          textOutput("t1"),
          h3("Prediction - Passenger survived? (1=Yes, 0=No) :"),
          textOutput("pred1")

    )
  )
))
