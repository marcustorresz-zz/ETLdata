######################### SEMANA 10 #################

######################## VALORES AUSENTES ###########

if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require('funModeling')) install.packages('funModeling'); library('funModeling')
if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')



idade <- c(floor(runif(70, 0, 80)), NA, NA)
mean(idade)
mean(idade, na.rm = TRUE)

covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')

## identificando e removendo valores ausentes
status(covid19PE) # estrutura dos dados (missing etc)

# Complete-case analysis – listwise deletion
dim(covid19PECompleto <- na.omit(covid19PE)) # deixa apenas os casos completos, mas vale a pena?

# Variação de Complete-case analysis – listwise deletion
dim(covid19PECompleto <- covid19PE %>% filter(!is.na(faixa_etaria)))

## estimando se o NA é MCAR, MAR ou MANR (pege 354 in r in action) 

#Essas definições foram retiradas deste link https://stefvanbuuren.name/fimd/sec-MCAR.html
#If the probability of being missing is the same for all cases, then the data are said to be missing completely at random (MCAR).
#If the probability of being missing is the same only within groups defined by the observed data, then the data are missing at random (MAR). 
#If neither MCAR nor MAR holds, then we speak of missing not at random (MNAR)

## Shadow Matrix do livro R in Action

data(sleep, package = "VIM") # importa a base sleep

head(sleep) # observa a base

x <- as.data.frame(abs(is.na(sleep))) # cria a matrix sombra
head(x) # observa a matriz sombra

y <- x[which(sapply(x, sd) > 0)] # mantém apenas variáveis que possuem NA
cor(y) # observa a correlação entre variáveis

cor(sleep, y, use="pairwise.complete.obs") # busca padrões entre os valores específicos das variáveis e os NA

## Shadow Matrix da nossa base de covid19 com adaptações

covid19PENA <- as.data.frame(abs(is.na(covid19PE))) # cria a matriz sombra da base de covid19

covid19PENA <- covid19PENA[which(sapply(covid19PENA, sd) > 0)] # mantém variáveis com NA
round(cor(covid19PENA), 3) # calcula correlações #Marcus: correlação mediana, mas com muitos NAs não significa nada

# modificação já que vão temos uma base numérica
covid19PENA <- cbind(covid19PENA, municipio = covid19PE$municipio) # trazemos uma variável de interesse (municípios) de volta pro frame
covid19PENAMun <- covid19PENA %>% group_by(municipio) %>% summarise(across(everything(), list(sum))) # sumarizamos e observamos se os NA se concentram nos municípios com mais casos



################## OUTLIERS ##################################


if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require("dplyr")) install.packages('dplyr'); library('dplyr')
if (!require('plotly')) install.packages('plotly'); library('plotly')

rm(list=ls())

# carregar dados covid19 Pernambuco
covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')

#qtde por mun
covid19PEMun <- covid19PE %>% count(municipio, sort = T, name = 'casos') %>% mutate(casos2 = sqrt(casos), casosLog = log10(casos))

## outliers em variáveis
# distância interquartil

plot_ly(y = covid19PEMun$casos, type = "box", text = covid19PEMun$municipio, boxpoints = "all", jitter = 0.3)
boxplot.stats(covid19PEMun$casos)$out
boxplot.stats(covid19PEMun$casos, coef = 2)$out # coef para verificar a distancia interquartil. Gerlamente é 1,5, mas nesse caso está 2

covid19PEOut <- boxplot.stats(covid19PEMun$casos)$out
covid19PEOutIndex <- which(covid19PEMun$casos %in% c(covid19PEOut))
covid19PEOutIndex

# filtro de Hamper (usa a mediana do desvio. Vê mais outliers, principalmente em dados não parametricos)
lower_bound <- median(covid19PEMun$casos) - 3 * mad(covid19PEMun$casos, constant = 1)
upper_bound <- median(covid19PEMun$casos) + 3 * mad(covid19PEMun$casos, constant = 1)
(outlier_ind <- which(covid19PEMun$casos < lower_bound | covid19PEMun$casos > upper_bound))

# teste de Rosner 
if (!require('EnvStats')) install.packages('EnvStats'); library('EnvStats')
covid19PERosner <- rosnerTest(covid19PEMun$casos, k = 10)
covid19PERosner
covid19PERosner$all.stats


##################### IMPUTAÇÃO ################

rm(list=ls())

if (!require('data.table')) install.packages('data.table'); library('data.table')

## imputação numérica
# preparação da base, colocando NA aleatórios
irisDT <- iris %>% setDT() #copiar base iris, usando a data.table

(irisNASeed <- round(runif(10, 1, 50))) # criamos 10 valores aleatórios

(irisDT$Sepal.Length[irisNASeed] <- NA) # imputamos NA nos valores aleatórios

# tendência central
library(Hmisc) # biblio que facilita imputação de tendência central
irisDT$Sepal.Length <- impute(irisDT$Sepal.Length, fun = mean) # média
irisDT$Sepal.Length <- impute(irisDT$Sepal.Length, fun = median) # mediana

is.imputed(irisDT$Sepal.Length) # teste se o valor foi imputado
table(is.imputed(irisDT$Sepal.Length)) # tabela de imputação por sim / não

# predição
irisDT$Sepal.Length[irisNASeed] <- NA # recolocamos os NA

regIris <- lm(Sepal.Length ~ ., data = irisDT) # criamos a regressão
irisNAIndex <- is.na(irisDT$Sepal.Length) # localizamos os NA
irisDT$Sepal.Length[irisNAIndex] <- predict(regIris, newdata = irisDT[irisNAIndex, ]) # imputamos os valores preditos

## Hot deck
# imputação aleatória
irisDT$Sepal.Length[irisNASeed] <- NA # recolocamos os NA

(irisDT$Sepal.Length <- impute(irisDT$Sepal.Length, "random")) # fazemos a imputação aleatória

# imputação por instâncias
irisDT$Sepal.Length[irisNASeed] <- NA # recolocamos os NA

if (!require('VIM')) install.packages('VIM'); library('VIM')
irisDT2 <- kNN(irisDT)