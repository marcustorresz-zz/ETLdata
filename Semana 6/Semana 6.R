########################## SEMANA 6 ###########################
########################### SMALL E LARGE DATA #################


if (!require('ff')) install.packages('ff'); library('ff')
if (!require('ffbase')) install.packages('ffbase'); library('ffbase')

setwd("C:/Users/marvi/OneDrive - Universidade Federal de Pernambuco/UFPE/DOUTORADO/2021.1/Disciplinas/ETL/ETLdata")


############### CRIAR O BANCO ######################

install.packages('data.table')
library(data.table)

casos= 2e7 # reduza os números antes e depois do e, caso esteja difícil de computar # mas tente manter pelo menos 1e6, para garantir o efeito se large data

# cria o data.frame com o total de casos definido acima
largeData = data.table(a=rpois(casos, 3),
                       b=rbinom(casos, 1, 0.7),
                       c=rnorm(casos),
                       d=sample(c("fogo","agua","terra","ar"), casos, replace=TRUE),
                       e=rnorm(casos),
                       f=rpois(casos, 3),
                       g=rnorm(casos)
)

object.size(largeData) # retorna o tamanho do objeto

head(largeData) # vê as primeiras linhas

write.table(largeData,"bases_originais/largeData.csv",sep=",",row.names=FALSE,quote=FALSE) # salva em disco

# versão menor

casos= 9e6 # reduza os números antes e depois do e, caso esteja difícil de computar # mas tente manter pelo menos 1e6, para garantir o efeito se large data

# cria o data.frame com o total de casos definido acima
largeData1 = data.table(a=rpois(casos, 3),
                        b=rbinom(casos, 1, 0.7),
                        c=rnorm(casos),
                        d=sample(c("fogo","agua","terra","ar"), casos, replace=TRUE),
                        e=rnorm(casos),
                        f=rpois(casos, 3)
)

object.size(largeData1) # retorna o tamanho do objeto

head(largeData1) # vê as primeiras linhas

write.table(largeData1,"bases_originais/largeData1.csv",sep=",",row.names=FALSE,quote=FALSE) # salva em disco

#####################################################################################

###################### SEGUNDA PARTE DA AULA - SMALL AND MEDIUM DATA ################

library(data.table)

enderecoBase <- 'bases_originais/largeData.csv'

# extração direta via read.csv
system.time(extracaoLD1 <- read.csv2(enderecoBase))

# extração via amostragem com read.csv, para verificar de maneira mais rápida.

# ler apenas as primeiras 20 linhas
amostraLD1 <- read.csv2(enderecoBase, nrows=20)  

amostraLD1Classes <- sapply(amostraLD1, class) # encontra a classe da amostra amostra

# fazemos a leitura passando as classes de antemão, a partir da amostra
system.time(extracaoLD2 <- data.frame(read.csv2("bases_originais/largeData.csv", colClasses=amostraLD1Classes) ) )  

# extração via função fread, que já faz amostragem automaticamente
system.time(extracaoLD3 <- fread(enderecoBase))

#?fread() é um readtable mais rápido, porque não precisa ler como character



###############################TERCEIRA PARTE DA AULA  ###########################

enderecoBase <- 'bases_originais/largeData.csv'

# criando o arquivo ff
system.time(extracaoLD4 <- read.csv.ffdf(file=enderecoBase))

class(extracaoLD4) # veja a classe do objeto

object.size(extracaoLD3) # a vantagem está no tamanho!

object.size(extracaoLD4) # a vantagem está no tamanho!

sum(extracaoLD4[,3]) # algumas operações são possíveis diretamente

lm(c ~ ., extracaoLD4) ## não vai rodar!!!! o vetor de computação será mt grande

# pra outras, será preciso amostrar...
extracaoLD4Amostra <- extracaoLD4[sample(nrow(extracaoLD4), 100000) , ]

lm(c ~ ., extracaoLD4Amostra) # aí, funciona!!!

system.time(extracaoLD5 <- read.csv.ffdf(file='bases_originais/Phones_accelerometer.csv'))

length(extracaoLD5$Model)

system.time(extracaoLD6 <- read.csv.ffdf(file='bases_originais/Phones_gyroscope.csv'))

length(extracaoLD6$Model)

extracaoMerge <- ffdfappend(extracaoLD5, extracaoLD6) # junta bases semelhantes

#extracaoMerge <- ffdfrbind.fill(extracaoLD5, extracaoLD6) # junta bases semelhantes forçando preenchimento

length(extracaoMerge$Model)