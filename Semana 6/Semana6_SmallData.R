############################# ATIVIDADE SMALL DATA ###################

#Professor, nesse momento eu tenho que fazer o jabá do pacote que desenvolvi com um amigo.
# O siconvr é um pacote que fazer a Extração e o Tratamento de dados do Sistema de Convênios Federais (SICONV)

############### Mais informações aqui - https://fmeireles.com/siconvr/

enderecoBase <- "bases_originais/propostas.csv"

rm(list=ls())

if (!require('ff')) install.packages('ff'); library('ff')

if(!require(remotes)) install.packages("remotes")
remotes::install_github("meirelesff/siconvr")

library(siconvr)

system.time (propostas <- get_siconv("propostas"))

object.size(propostas)

write.csv(propostas, "bases_originais/propostas.csv")

system.time(propostas_2 <- read.csv2("bases_originais/propostas.csv", sep = ","))

system.time(propostas_3 <- fread("bases_originais/propostas.csv", sep = ","))


#Amostra das Propostas

system.time(sample <- read.csv2("bases_originais/propostas.csv", nrows=20, sep = ","))

