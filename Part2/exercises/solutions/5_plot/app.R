library(shiny)
library(tidyverse)

advs <- read_csv("data/advs.csv")
dataset <- advs

ui <- fluidPage(

    titlePanel("Exercise 5"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "x_var", 
                        label = "select x variable",
                        choices = colnames(dataset),
                        selected = "VISITNUM"),
            selectInput(inputId = "y_var", 
                        label = "select y variable",
                        choices = colnames(dataset),
                        selected = "AVAL"),
            selectInput(inputId = "subject", 
                        label = "select subject",
                        choices = unique(dataset$USUBJID)),
            selectInput(inputId = "param", 
                        label = "select param",
                        choices = unique(dataset$PARAM))
        ),

        mainPanel(
           plotOutput("scatterplot")
        )
    )
)

server <- function(input, output) {

    output$scatterplot <- renderPlot({
 
        filtered_data() %>%
            ggplot(aes(x = .data[[input$x_var]],
                       y = .data[[input$y_var]]))+
            geom_point()
        
    })
        
    filtered_data <- reactive({
        
        dataset %>%
            filter(USUBJID == input$subject) %>%
            filter(PARAM == input$param)
    })    
}

shinyApp(ui = ui, server = server)
