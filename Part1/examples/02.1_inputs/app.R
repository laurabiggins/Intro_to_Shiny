library(shiny)
library(bslib)

ui <- page_fillable(
  
  layout_column_wrap(
    width = 1/4, height = 150, title = "Inputs",

    card(
      card_header("actionButton()"),
      actionButton(inputId = "", label = "action button")
    ),
    card(
      card_header("actionLink()"), 
      actionLink(inputId = "", label = "action link")
    ),
    card(
      card_header("checkboxGroupInput()"), 
      checkboxGroupInput(inputId = "", label = NULL, choices = c("apple", "pear", "banana"))
    ),
    card(
      card_header("checkboxInput()"),
      checkboxInput(inputId = "", label = "single checkbox")
    ),
    card(
      card_header("dateInput()"),
      dateInput(inputId = "", label = NULL)
    ),
    # card(
    #   card_header("dateRangeInput()"),
    #   dateRangeInput(inputId = "", label = NULL)
    # ),  # remove this so they fit in a grid layout better
    card(
      card_header("numericInput()"),
      numericInput( inputId = "", label = NULL, value = 8)
    ),
    card(
      card_header("passwordInput()"),
      passwordInput(inputId = "", label = NULL)
    ),
    
    card(
      card_header("radioButtons()"),
      radioButtons(inputId = "", label = NULL, choices = c("choose me", "or me", "or this option"))
    ),
    
    card(
      card_header("selectInput()"),
      selectInput(inputId = "", label = NULL, choices = c("choose me", "or me", "or this option"))
    ),
    
    card(
      card_header("sliderInput()"),
      sliderInput(inputId = "", label = NULL, min = 5, max = 500, value = 20, step = 50)
    ),
    
    card(
      card_header("textInput()"),
      textInput(inputId = "", label = NULL)
    ),
    
    card(
      card_header("fileInput()"),
      fileInput(inputId = "", label = NULL)
    )
  )
)
    
    

  
server <- function(input, output, session) {
}

shinyApp(ui, server)
