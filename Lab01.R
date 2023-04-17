library(readr)
library(stringr)
library(dplyr)
library(tidyr)

info_data <- read_table("D:/epa-http.csv", col_names = FALSE)
View(info_data)