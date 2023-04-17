library(readr)
library(stringr)
library(dplyr)
library(tidyr)

# Importando el archivo
info_data <- read_table("D:/epa-http.csv", col_names = FALSE)
# Renonbrando los encabezados de las columnas
colnames(info_data) <- c("Directions", "Timestamp", "Method", "Resource", "Protocol", "Response Code", "Size")

View(info_data)