

##################### EXERCICIO 3 ##############################

########pacotes#######
rm(list=ls())

if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require('VIM')) install.packages('VIM'); library('VIM')
if (!require('Hmisc')) install.packages('Hmisc'); library('Hmisc')


#1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html

covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')



#2. Corrija os NAs da coluna sintomas através de imputação randômica 

covid_sintomas <- covid19PE %>% setDT() #copiar base iris, usando a data.table

(covidNASeed <- table(covid_sintomas$sintomas)) # criamos 10 valores aleatórios

(covid_sintomas$sintomas[covidNASeed] <- NA) # imputamos NA nos valores aleatórios


??impute()

covid_sintomas$sintomas[covidNASeed] <- NA # recolocamos os NA

(covid_sintomas$sintomas <- impute(covid_sintomas$sintomas,"random")) # fazemos a imputação aleatória

#3. Calcule, para cada município do Estado, o total de casos confirmados e negativos
#4. Crie uma variável binária se o sintoma inclui tosse ou não e calcule quantos casos confirmados e negativos tiveram tosse como sintoma
#5. Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos