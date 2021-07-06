#Criem um objeto próprio de data e tempo,
#convertam pros três formatos de data e tempo, e façam pelo menos 3 extrações de componentes e/ou operações.



rm(list=ls())

if (!require('tesseract')) install.packages('tesseract'); library('tesseract')
if (!require('tabulizer')) install.packages('tabulizer'); library('tabulizer')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('pdftools')) install.packages('pdftools'); library('pdftools')
if (!require('quanteda')) install.packages('quanteda'); library('quanteda')
if (!require('readtext')) install.packages('readtext'); library('readtext')
if (!require('gsubfn')) install.packages('gsubfn'); library('gsubfn')
if (!require('lubridate')) install.packages('lubridate'); library('lubridate')


#Semanas Epidemiológicas - 2020 da pref do RJ
rio <- pdf_text("http://www.rio.rj.gov.br/dlstatic/10112/7381390/4261801/SEMANAEPIDEMIOLOGICA2020.pdf")

#Sistema de Informação de Agravos de Notificação
ms <- pdf_text("https://portalsinan.saude.gov.br/images/documentos/Calendario/2021.pdf")

#Substitue
data_rio <- gsub("/", "-", rio)
data_ms <- gsub("/", "-", ms)

#Extract
strapplyc(data_rio, "\\d+-\\d+-\\d+", simplify = TRUE)
strapplyc(data_ms, "\\d+-\\d+-\\d+", simplify = TRUE)


############ Atvidade ##########
data <- as.data.frame(strapplyc(data_rio, "\\d+-\\d+-\\d+", simplify = TRUE))
data$data <- as.POSIXlt(data$V1, format = "%d-%m-%Y")
class(data$data)




#Componentes

year(data$data) # ano

month(data$data) # mês

month(data$data, label = T) # mês pelo nome usando label = T

wday(data$data, label = T, abbr = T) # dia da semana abreviado

isoweek(data$data) # semana ISO 8601

epiweek(data$data) # semana epidemiológica

### Operações


data$data + minutes(90) # período

data$data + hours(90) # duração

data$data + weeks(90) # duração
