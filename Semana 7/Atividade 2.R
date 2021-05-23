################### ATIVIDADE 2 ############


#O segundo exercício tem por base o que aprendemos sobre ETL e large data. 

#1. Extraia em padrão ff todas as bases de situação final de alunos disponíveis neste endereço: http://dados.recife.pe.gov.br/dataset/situacao-final-dos-alunos-por-periodo-letivo
#2. Junte todas as bases extraídas em um único objeto ff
#3. Limpe sua staging area
#4. Exporte a base única em formato nativo do R


rm(list=ls())

if (!require('ff')) install.packages('ff'); library('ff')
if (!require('ffbase')) install.packages('ffbase'); library('ffbase')

setwd("C:/Users/marvi/OneDrive - Universidade Federal de Pernambuco/UFPE/DOUTORADO/2021.1/Disciplinas/ETL/ETLdata")
