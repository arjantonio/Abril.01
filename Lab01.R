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
info_data$Formatted_date <- as.POSIXlt(info_data$Timestamp,format="[%d:%H:%M:%OS]")
info_data$Fecha02 <- str_sub(info_data$Formatted_date, -8)
info_data$Protocol <- as.factor(info_data$Protocol)
# Pregunta 01 -b
# Valor medio de la Columna Byte
summary(info_data$Size)
# Resultado: 7352
#      Min. 1st Qu.  Median    Mean   3rd Qu.    Max.     NA's 
      #  0     231    1260    7352    3223     4816896    5331 

# Pregunta 02
# Cuantas pertenecen a ".edu"
# Validando quienes tienen la extensión .edu
edu_ips <- str_count(info_data$Directions, "\\.edu")

# Hallando el n° de ips con extension edu
total_ips <- sum(edu_ips)
total_ips
# El resultado de las ips que contienen edu es 6524
# Otra forma de hallar las ips con extension .edu
# Ext_edu <- info_data[grepl(".edu", info_data$Directions), ]
# Ext_edu

#PREGUNTA 3
# Se realiza el filtro para GET
get_method <- filter(info_data, str_detect(info_data$Method2, "GET"))
View(get_method)
# Escogiendo las columnas method2 y Formatted_date 
method_data <- select(get_method,Method2,Formatted_date )
# Obteniendo la hora
method_data$Hora <- method_data$Formatted_date$hour
# Realizando el conteo y ordenando de mayor a menor
hour_max <- count(method_data, Hora, sort = TRUE)
hour_max
# El resultado es a las 14 horas (2:00 pm) con  4546 peticiones

#Pregunta 4
# Bytes tx de .txt de (.edu)
Edu <- info_data[grepl("\\.edu", info_data$Directions), ]
# Validación para solo filtrar .txt
Txt <- Edu[grepl("\\.txt", Edu$Resource), ]
sum(Txt$Size, na.rm=TRUE)
# Bytes transmitidos: 2705408

# Para validaciones .txt al final se usa lo siguiente
txt_data <- filter(Edu, str_detect(Edu$Resource, "\\.txt$"))
sum(na.omit(txt_data$Size))
# bytes transmitidos:106806

# Pregunta 5
#Cuantas peticiones buscan la URL: "/"
info_data$Resource <- as.factor(info_data$Resource)
Peticiones <- info_data[grepl("^/$", info_data$Resource), ]
summary(Peticiones)
# El resultado es 2382
# Otra forma
# sum(str_detect(request_data$Resource2, "^/$"))


#Pregunta 6
#summary(info_data)
# Hallando los protocoloes que no tiene http/0.2
http1_total <- sum(!str_detect(info_data$Protocol, "HTTP/0.2"))
http1_total
# El resultado es 47747
