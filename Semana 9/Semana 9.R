############## TIPOS E FATORES ##############


# Códigos do livro An Introduction to data cleaning with R

class(c("abc", "def"))
class(1:10)
class(c(pi, exp(1)))
class(factor(c("abc", "def")))

vrNumeric <- c("7", "7*", "7.0", "7,0")
is.numeric(vrNumeric)
as.numeric(vrNumeric)
as.integer(vrNumeric)
as.character(vrNumeric)

is.na(as.numeric(vrNumeric))

vrFactor <- factor(c("a", "b", "a", "a", "c"))
levels(vrFactor)

gender <- c(2, 1, 1, 2, 0, 1, 1)
recode <- c(male = 1, female = 2)
(gender <- factor(gender, levels = recode, labels = names(recode)))

(gender <- relevel(gender, ref = "female"))

age <- c(27, 52, 65, 34, 89, 45, 68)
(gender <- reorder(gender, age))

attr(gender, "scores") <- NULL
gender




#######################   Mais fatores ###############
rm(list=ls())
if (!require('arules')) install.packages('arules'); library('arules')
if (!require('forcats')) install.packages('forcats'); library('forcats')
if (!require('ade4')) install.packages('ade4'); library('ade4')
if (!require('RCurl')) install.packages('RCurl'); library('RCurl') #Para baixar diretamente


facebookurl <- "https://raw.githubusercontent.com/hugoavmedeiros/etl_com_r/master/bases_originais/dataset_Facebook.csv"
facebook <- read.csv(facebookurl, sep=";", header = T)

#ver a estrutura
str(facebook)

# conversão em fatores
for(i in 2:7) {
  facebook[,i] <- as.factor(facebook[,i]) } 

str(facebook)
levels(facebook$Type)

#Fatores p/ dummies -> redes neurais
#Fatores p/ discretos -> redes bayesianas


# filtro por tipo de dado

factorsFacebook <- unlist(lapply(facebook, is.factor))  #Mostra quais variáveis são fatores e quais não são
facebookFactor <- facebook[ , factorsFacebook] #pega as variáveis que são fatores
str(facebookFactor)

# One Hot Encoding, transforma tudo em dummy, para as redes neurais
facebookDummy <- acm.disjonctif(facebookFactor) #função de disjunção do pacote ad4

# Discretização #Para análise de redes bayesiana
inteirosFacebook <- unlist(lapply(facebook, is.integer))  #Vê quais variáveis são inteiras
facebookInteiros <- facebook[, inteirosFacebook] #seleciona os innteiros
str(facebookInteiros)

#criar tres categorias
facebookInteiros$Page.total.likes.Disc <- discretize(facebookInteiros$Page.total.likes, method = "interval", breaks = 3, labels = c("poucos", 'médio', 'muitos')) #discretiza os likes

# forcats - usando tidyverse para fatores
fct_count(facebookFactor$Type) # conta os fatores

fct_anon(facebookFactor$Type) # anonimiza os fatores

fct_lump(facebookFactor$Type, n = 1) # reclassifica os fatores em mais comum e outros

##################################DATA TABLE##############

library(data.table)
library(dplyr)

irisDT <- iris %>% setDT()
class(irisDT)

irisDT[species == 'setosa', ] #i, j, by

irisDT[species != 'setosa', ]

irisDT[Sepal.Length > 5 & species == 'setosa', ]

irisDT[.N]

irisDT[(.N-3)]

irisDT[ , Species]

cols <- c("Species", "Petal.Width")
irisDT[ , ..cols]

irisDT[Species == 'setosa', ][Sepal.Length > 5, ]

irisDT[ , .(Sepal.Length = mean(Sepal.Length, na.rm = T))]

irisDT[ , lm(formula = Sepal.Length ~ species + Sepal.Width + Petal.Length + Petal.Width)]

irisDT[ , .(Sepal.Length = mean(Sepal.Length, na.rm = T)), by = species]


#################### dplyt##############

