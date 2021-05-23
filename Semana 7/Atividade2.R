################### ATIVIDADE 2 ############


#O segundo exercício tem por base o que aprendemos sobre ETL e large data. 




######################## PACOTES ###############################
rm(list=ls())

if (!require('ff')) install.packages('ff'); library('ff')
if (!require('ffbase')) install.packages('ffbase'); library('ffbase')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('plyr')) install.packages('plyr'); library('plyr')
if (!require('readr')) install.packages('readr'); library('readr')

setwd("C:/Users/marvi/OneDrive - Universidade Federal de Pernambuco/UFPE/DOUTORADO/2021.1/Disciplinas/ETL/ETLdata/Semana 7")

#1. Extraia em padrão ff todas as bases de situação final de alunos disponíveis neste endereço: 
# http://dados.recife.pe.gov.br/dataset/situacao-final-dos-alunos-por-periodo-letivo

data2020 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/9dc84eed-acdd-4132-9f1a-a64f7a71b016/download/situacaofinalalunos2020.csv")
data2019 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/3b03a473-8b20-4df4-8628-bec55541789e/download/situacaofinalalunos2019.csv")
data2018 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/8f3196b8-c21a-4c0d-968f-e2b265be4def/download/situacaofinalalunos2018.csv")
data2017 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/70c4e6fc-91d2-4a73-b27a-0ad6bda1c84d/download/situacaofinalalunos2017.csv")
data2016 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/f42a3c64-b2d7-4e2f-91e5-684dcd0040b9/download/situacaofinalalunos2016.csv")
data2015 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/264f0a37-ad1c-4308-9998-4f0bd3c6561f/download/situacaofinalalunos2015.csv")
data2014 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/0a2aec2f-9634-4408-bbb4-37e1f9c74aa1/download/situacaofinalalunos2014.csv")
data2013 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/95eb9ea8-cd75-4efa-a1ba-ba869f4e92b9/download/situacaofinalalunos2013.csv")
data2012 <- read.csv.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/f6633c26-be36-4c27-81cb-e77d90316cff/download/situacaofinalalunos2012.csv")

#2. Junte todas as bases extraídas em um único objeto ff.
# Não sei por que, mas eu tentei juntar os bancos no total e não consegui fazendo uma lista. Há alguma maneira mais efetiva
DATA <- ffdfappend(data2020,data2019,data2018) 
DATA2 <- ffdfappend(data2017,data2016,data2015)  
DATA3 <- ffdfappend(data2014,data2013,data2012)
DATA <- ffdfappend(DATA,DATA2,DATA3)

#3. Limpe sua staging area
rm(list=(ls()[ls()!="DATA"]))



#4. Exporte a base única em formato nativo do R
write_rds(DATA, "DATA.rds")


??commmit
