#
# This is the server logic of a Shiny web application.
#

library(shiny)
library(data.table)

shinyServer(function(input, output) {
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
    
    model1pred <- reactive({
        mpgInput <- input$sliderMPG
        
        brushed_data <- brushedPoints(mtcars, input$brush1, xvar = "mpg", yvar = "hp")
        if(nrow(brushed_data) < 2){
            return( predict(model1, newdata = data.frame(mpg = mpgInput)) )
        }
        predict(modelx(), newdata = data.frame(mpg = mpgInput))
    })
    
    modelx <-  reactive({
        brushed_data <- brushedPoints(mtcars, input$brush1, xvar = "mpg", yvar = "hp")
        if(nrow(brushed_data) < 2){
            return( NULL )
        }
        lm(hp ~ mpg, data = brushed_data)
    })
    
    model2pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model2, newdata = 
                    data.frame(mpg = mpgInput,
                               mpgsp = ifelse(mpgInput - 20 > 0,
                                              mpgInput - 20, 0)))
    })
    output$plot1 <- renderPlot({
        mpgInput <- input$sliderMPG
        model <- model1
        if (!is.null(modelx()) )  model <- modelx() 
                
        plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
             ylab = "Horsepower", bty = "n", pch = 16,
             xlim = c(10, 35), ylim = c(50, 350),
             main = "You can select points on plot to change Model 1 Prediction")
        
        if(input$showModel1){
            abline(model, col = "red", lwd = 2)
        }
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
            ))
            lines(10:35, model2lines, col = "blue", lwd = 2)
        }
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})