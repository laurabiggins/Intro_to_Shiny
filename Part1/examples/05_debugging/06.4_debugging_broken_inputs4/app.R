library(shiny)

ui <- fluidPage(
  
  titlePanel("Inputs"),
  
  textInput(inputId = "name", label = "Enter name"),
  
  numericInput(inputId = "number_chosen", 
               label = "Choose a number", 
               value = 15),
  
  sliderInput(inputId = "slider", 
              label   = "Choose another number",
              min = 0, max = 30, value = 10, step = 1),
  
  radioButtons(inputId = "radio", 
               label = "", 
               choices = c("walk", "run", "cycle"), 
               inline = TRUE),
  br(),
  textOutput(outputId = "supplied_name"),
  textOutput(outputId = "info"),
  textOutput(outputId = "transport_choice"),
  br(),
  actionButton(inputId = "browser", "browser")
)

server <- function(input, output, session) {
  
  observeEvent(input$browser, browser())
  
  output$supplied_name <- renderText({
    paste0("Hello ", input$user_name)
  })
  
  output$info <- renderText({
    paste0("Your two numbers are ", 
           input$number_chosen, 
           " and ", 
           input$slider)
    })
  
  output$transport_choice <- renderText({
    paste0("You've chosen to ", input$radio)
  })  
}

shinyApp(ui, server)
