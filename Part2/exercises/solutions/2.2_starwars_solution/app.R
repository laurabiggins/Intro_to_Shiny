library(shiny)
library(tidyverse)

# Task:
# 1. put the slider in a sidebar panel
# 2. Extract the repeated code in the server function and put it into a reactive expression to subset the data based on the slider range
# 3. Use isolate() with an update button so that the plot and table
# do not update until the button is pressed.
ui <- fluidPage(

  titlePanel("Exercise 2"),

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "slider_range",
        label = "Data range:",
        min = 1,
        max = nrow(starwars),
        value = c(1, 10)
      ),
      actionButton("update", "Update"),
      width = 3,
    ),
    mainPanel(
      plotOutput("bar_plot", height = 300),
      tableOutput("starwars_table"),
      width = 9
    )
  )
)

server <- function(input, output) {

  data_subset <- reactive({

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
