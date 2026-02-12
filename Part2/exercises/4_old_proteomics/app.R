library(shiny)
library(tidyverse)
library(DT)

# Exercise 4
# 
# 1. Add select inputs so any of the conditions (naive or primed) can be plotted on the x or y axes.
# 2. Use a sidebar layout to separate the inputs from the plot
# 3. a. Add a slider to allow the user to select the range of PepCounts. 
#    b. Use a reactive expression to create a dataset filtered by the pepcount range. 
#       This should be used in the table and the plot.
# 
# [Optional]      
# 4. Change the tableOutput to a dataTableOutput. Remember to change the corresponding render function too. 
# 5. Highlight selected genes on the plot (use input$[data_table_name]_rows_selected to get the selected row numbers)
# 6. Add an actionButton to clear the selected rows (you can use the function dataTableProxy())
# 
# 7. Use a tabset layout to add another plot that shows each of the values for a selected
# gene. e.g. a jitter plot coloured by naive vs primed.


load("data/wide_data.rda")

ui <- fluidPage(
  
  titlePanel("Exercise 4"),
  
  plotOutput(outputId = "scatter", height = 400, width = 400),
  
  tableOutput("table")
)

server <- function(input, output, session) {
  
  output$scatter <- renderPlot({
    
    wide_data %>%
      ggplot(aes(x = NAIVE_R1, y = PRIMED_E1)) +
        geom_point()
    
  })
  
  output$table <- renderTable({
    
    head(wide_data)
    
  })  
  
}

shinyApp(ui, server)
