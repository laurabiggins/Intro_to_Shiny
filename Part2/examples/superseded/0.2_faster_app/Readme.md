Shiny app with multiple inputs.

The slow code has been put into a reactive expression so it's result is cached.
When it is called from renderPlot(), the code only runs when the value of 
input$slider has been updated.
