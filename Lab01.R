library(readr)
library(stringr)
library(dplyr)
library(tidyr)

# Importando el archivo
info_data <- read_table("D:/epa-http.csv", col_names = FALSE)
# Renonbrando los encabezados de las columnas
colnames(info_data) <- c("Directions", "Timestamp", "Method", "Resource", "Protocol", "Response Code", "Size")

View(info_data)
info_data$Siza <- as.numeric(info_data$Size)
info_data$Method2 <- str_sub(info_data$Method, 2)
info_data$Method2 <- as.factor(info_data$Method2)
info_data$Fecha01 <- strptime(info_data$Timestamp, format = "[%d:%H:%M:%S]")
info_data$Fecha02 <- str_sub(info_data$Fecha01, -8)