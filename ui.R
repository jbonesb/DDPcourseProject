#
# This is user interface of my app
#

library(shiny)

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Horsepower from MPG"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                tabPanel("Main", br(), 
                     plotOutput("plot1", brush = brushOpts(id = "brush1") ),
                     h3("Predicted Horsepower from Model 1:"),
                     textOutput("pred1"),
                     h3("Predicted Horsepower from Model 2:"),
                     textOutput("pred2")
                ),
                tabPanel("Help", br(), 
                    h3("How to use this App"),
                    br(),

                    p("This is the simply prediction app that use linier regression model to predict *mpg* on mtcars dataset."),
                    br(),
                    p("- You can use slider to select MPG for prediction."),
                    p("- You can switch on/off model visualisation on plot."),
                    p("- You can select some points on plot to produce Model 1 prediction on this points."),
                    br()
                )
            )
        )
    )
))