library(shiny)

ui <- fluidPage(
  
  br(),

  textInput(inputId = "user_name", label = "Enter name"),

  numericInput(inputId = "number_chosen", 
               label = "Choose a number", 
               value = 15),
  
  sliderInput(inputId = "slider", 
              label   = "Choose another number",
              min = 0, max = 30, value = 10, step = 1),
  
  radioButtons(inputId = "radio", label = "", inline = TRUE,
               choices = c("walk", "run", "cycle")),

  h4(
    textOutput(outputId = "supplied_name"),
    textOutput(outputId = "info"),
    textOutput(outputId = "transport_choice")
  )   
)

server <- function(input, output, session) {
  
  output$supplied_name <- renderText(paste0("Hello ", input$user_name))
  
  output$info <- renderText(paste0("Your two numbers are ", 
                                   input$number_chosen, 
                                   " and ", 
                                   input$slider)
                                  )
  
  output$transport_choice <- renderText(paste0("You've chosen to ", input$radio))
  
}

shinyApp(ui, server)




# not using a render function in output$transport_choice
# output$transport_choice <- renderText(