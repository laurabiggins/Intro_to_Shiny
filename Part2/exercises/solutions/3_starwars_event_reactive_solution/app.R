library(shiny)
library(dplyr)

# Task:
# 1. Instead of using the isolate function, use eventReactive() to delay the update
# of the data. You'll need to use the ignoreNULL = FALSE argument in eventReactive for 
# the plot to be shown on start up of the app.
# 
 
ui <- fluidPage(

    titlePanel("Exercise x part 2 "),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider_range",
                        "Data range:",
                        min = 1,
                        max = nrow(starwars),
                        value = c(1, 10)),
            actionButton("update", "Update"),
            width = 3,
        ),
        mainPanel(
            plotOutput("bar_plot", height = 500),
            tableOutput("starwars_table"),
            width = 9
        )
    )
)

server <- function(input, output) {

    data_subset <- eventReactive(input$update, ignoreNULL = FALSE, {

        starwars %>%
           slice(input$slider_range[1]:input$slider_range[2])
    })
    
    output$bar_plot <- renderPlot({

        data_subset() %>%
                ggplot(aes(x = name, y = height, fill = homeworld)) +
                geom_col() +
                coord_flip()
        
    })
    
    output$starwars_table <- renderTable({
        
        data_subset() %>%
            select(-films, -vehicles, -starships)
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
