library(shiny)
library(dplyr)
library(ggplot2)

options(shiny.reactlog = TRUE)
all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(
  
  titlePanel("Chick weights"),
  
  sidebarLayout(
    sidebarPanel(width = 2,
                 checkboxGroupInput(
                   inputId = "selected_diets",
                   label   = "include diet",
                   choices = all_diets,
                   selected = all_diets
                 ),
                 br(),
                 sliderInput(inputId = "slider_line_width",
                             label = "line width",
                             min   = 1, 
                             max   = 5, 
                             value = 1),
                 br(),
                 actionButton("browser", "browser")
    ),
    
    mainPanel(
      plotOutput("chick_weights", width="600px", height="400px")
    )
  )
)


server <- function(input, output) {
  
  data_subset <- reactive({
    
    print(paste0("from data_subset reactive, diets = ", 
                 paste0(input$selected_diets, collapse = ",")))
    
    ChickWeight %>%
      filter(Diet %in% input$selected_diets)
  })
  
  calculate_line_width <- reactive({
    
    Sys.sleep(1)
    input$slider_line_width * 0.8
  })
  
  output$chick_weights <- renderPlot({
    
    print(paste0("from renderPlot, diets = ", 
                 paste0(input$selected_diets, collapse = ",")))
    
    data_subset() %>% 
      ggplot(aes(x = Time, 
                 y = weight, 
                 colour = Diet, 
                 group = interaction(Diet, Chick)))+
      geom_line(lwd = calculate_line_width())
  })
  
  
  observeEvent(input$browser, browser())
}















# Run the application 
shinyApp(ui = ui, server = server)

