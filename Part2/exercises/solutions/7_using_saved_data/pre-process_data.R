library(tidyverse)  # attaches purrr and readr
library(fs)

# There are 2 options here for importing and saving data - the first does this
# one file at a time.
# If there are many files, then it may be preferable to automate this as in option 2.
# for these 3 files, the amount of code is similar for the 2 options, but version 2
# will scale up to many files.

#==================================================
# 1. reading in and saving one data file at a time
#==================================================
adsl <- read_csv("raw_data/adsl.csv")
adae <- read_csv("raw_data/adae.csv")
advs <- read_csv("raw_data/advs.csv")

all_data <- list(adsl, adae, advs)
names(all_data) <- c("adsl", "adae", "advs")

save(all_data, file = "RData/all_data.RData")

# this would also work but each dataset would be loaded into the environment 
# under its own name
#save(adsl, adae, advs, file = "AZ_exercises/RData/datasets.RData") 

#=====================================================
# 2. reading in and saving all csv files in directory
#=====================================================
data_directory <- "raw_data"
csv_files <- fs::dir_ls(data_directory, regexp = "\\.csv$")

all_data <- map(csv_files, read_csv)

dataset_names <- gsub(".csv", "", path_file(csv_files))
names(all_data) <- dataset_names

save(all_data, file = "RData/all_data.RData")
