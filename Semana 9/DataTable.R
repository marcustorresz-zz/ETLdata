#Compartilhe com a gente um código criado por você com a aplicação direta do sumário de uma regressão linear, usando a sintaxe de data table.



if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require('ade4')) install.packages('ade4'); library('ade4')


data <- as.data.frame( UCBAdmissions)


boolean_data <- acm.disjonctif(data_fac)


data$anom <- fct_anon(data$Dept) # anonimiza os fatores


#regressão

data[ , lm(formula = Freq ~ anom)]
