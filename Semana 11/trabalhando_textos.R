########TRABALHANDO COM TEXTOS #################
rm(list=ls())

if (!require('tesseract')) install.packages('tesseract'); library('tesseract')
if (!require('tabulizer')) install.packages('tabulizer'); library('tabulizer')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('pdftools')) install.packages('pdftools'); library('pdftools')
if (!require('quanteda')) install.packages('quanteda'); library('quanteda')
if (!require('readtext')) install.packages('readtext'); library('readtext')
if (!require('gsubfn')) install.packages('gsubfn'); library('gsubfn')


# Compartilhe com a gente um código criado por você em que você carrega para o R um pdf que tenha alguma data; 
# em seguida, troca as barras "/" das datas por hífens "-", e, por fim, faz a extração das datas usando esse novo padrão.



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


