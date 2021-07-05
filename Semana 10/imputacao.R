# Compartilhe com a gente um código criado por você usando uma técnica de imputação numérica e uma técnica de hot deck para substituir NA.


if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require('VIM')) install.packages('VIM'); library('VIM')
if (!require('Hmisc')) install.packages('Hmisc'); library('Hmisc')



rm(list=ls())

data(sleep, package = "VIM") # importa a base sleep



# IMPUTACAO NUMERICA - tendência central
library(Hmisc) 
sleepnew<- sleep
sleepnew$NonD <- impute(sleep$NonD, fun = mean) # média
sleepnew$Dream <- impute(sleep$Dream, fun = mean) # média
sleenewp$Sleep <- impute(sleep$Sleep, fun = mean) # média

is.imputed(sleepnew$Dream) # foi timputado?
table(is.imputed(sleepnew$Dream)) # tabela de imputação por sim / não

# HOTDECK - por instancias

#Usa k neirghbor
sleepKNN <- kNN(sleep)
table(is.imputed(sleepKNN$Dream)) # tabela de imputação por sim / não

cor(sleepnew, sleepKNN) # Alas correlaççoes
