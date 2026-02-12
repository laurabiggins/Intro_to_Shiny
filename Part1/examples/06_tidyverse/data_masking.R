library(tidyverse)

# base R
iris[iris$Sepal.Length > 7 & iris$Petal.Width < 2, ]

# tidyverse
iris %>%
  filter(Sepal.Length > 7 & Petal.Width < 2)

# data masking -> minimises repetition
 
#===========================
var1 <- "Sepal.Length"
var2 <- "Petal.Width"

# base R
iris[iris$var1 > 7 & iris$var2 < 2, ]

iris[iris[[var1]] > 7 & iris[[var2]] < 2, ]


# tidyverse
iris %>%
  filter(var1 > 7 & var2 < 2)

iris %>%
  filter(.data[[var1]] > 7 & .data[[var2]] < 2)




