library(readr)
library(stringr)
library(dplyr)
library(tidyr)

# Importando el archivo
info_data <- read_table("D:/epa-http.csv", col_names = FALSE)
# Renonbrando los encabezados de las columnas
colnames(info_data) <- c("Directions", "Timestamp", "Method", "Resource", "Protocol", "Response Code", "Size")

View(info_data)
# Pregunta 1
# 1. Hallando las columnas y filas
dim(info_data)
# El resultado de la pregunta 1 es 47748 filas y  7 columnas

# Configuraciones
info_data$Size <- as.numeric(info_data$Size)
info_data$Method2 <- str_sub(info_data$Method, 2)
info_data$Method2 <- as.factor(info_data$Method2)
info_data$Fecha01 <- strptime(info_data$Timestamp, format = "[%d:%H:%M:%S]")
info_data$Fecha02 <- str_sub(info_data$Fecha01, -8)
# Pregunta 01 -b
# Valor medio de la Columna Byte
summary(info_data$Size)
# Resultado: 7352
#      Min. 1st Qu.  Median    Mean   3rd Qu.    Max.     NA's 
      #  0     231    1260    7352    3223     4816896    5331 

# Pregunta 02
# Cuantas pertenecen a ".edu"
# Validando quienes tienen la extensión .edu
edu_ips <- str_count(info_data$Directions, ".edu")

# Hallando el n° de ips con extension edu
total_ips <- sum(edu_ips)
total_ips
# El resultado de las ips que contienen edu es 6539
# Otra forma de hallar las ips con extension .edu
# Ext_edu <- info_data[grepl(".edu", info_data$Directions), ]
# Ext_edu

