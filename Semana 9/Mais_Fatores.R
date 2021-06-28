# Compartilhe com a gente um código criado por você com um processo de one hot encoding ou de discretização, 
#e também a transformação dos fatores de uma base de dados em 3 tipos: mais frequente, segundo mais frequente e outros.


if (!require('arules')) install.packages('arules'); library('arules')
if (!require('forcats')) install.packages('forcats'); library('forcats')
if (!require('ade4')) install.packages('ade4'); library('ade4')
if (!require('RCurl')) install.packages('RCurl'); library('RCurl') #Para baixar diretamente



rm(list = ls())

library(help = "datasets")


#dados de admissão da UC Berkeley
data <- as.data.frame( UCBAdmissions)

#selecionar os fatores
data_fac <-(lapply(data, is.factor))
data_fac <- data[ , data_fac] #pega as variáveis que são fatores


#transforma em dummy - Hot Encoding
boolean_data <- acm.disjonctif(data_fac)

#tranformar fatores
data$data_trans <- discretize(data$Freq, method = "interval", breaks = 4, labels = c("raro","passável", "difícil", "muito dificil")) 
