Shiny application with multiple inputs.

The code to calculate the point size on the plot has been moved into a reactive expression.
The app is still slow when the slider is moved and the code runs to calculate the 
point size, but as this value now gets cached, the slow piece of code does not need
to run every time one of the other inputs is changed.

