


#Compartilhe com a gente um código criado por você usando uma das técnicas de identificação de outliers,
#mas no lugar da variável casos, busque em uma das outras duas variáveis ajustadas (casos2 ou casosLog)


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

plot_ly(y = covid19PEMun$casosLog, type = "box", text = covid19PEMun$municipio, boxpoints = "all", jitter = 0.3) #Com o log, as variaveis de caso fazem mais sentido
boxplot.stats(covid19PEMun$casosLog)$out
boxplot.stats(covid19PEMun$casosLog, coef = 2)$out # coef para verificar a distancia interquartil. Gerlamente é 1,5, mas nesse caso está 2

covid19PEOut <- boxplot.stats(covid19PEMun$casosLog)$out
covid19PEOutIndex <- which(covid19PEMun$casosLog %in% c(covid19PEOut))
covid19PEOutIndex #casos outlier

# filtro de Hamper (usa a mediana do desvio. Vê mais outliers, principalmente em dados não parametricos)
lower_bound <- median(covid19PEMun$casosLog) - 3 * mad(covid19PEMun$casosLog, constant = 1)
upper_bound <- median(covid19PEMun$casosLog) + 3 * mad(covid19PEMun$casosLog, constant = 1)
(outlier_ind <- which(covid19PEMun$casosLog < lower_bound | covid19PEMun$casosLog > upper_bound))

# teste de Rosner 
if (!require('EnvStats')) install.packages('EnvStats'); library('EnvStats')
covid19PERosner <- rosnerTest(covid19PEMun$casosLog, k = 10)
covid19PERosner #somente os 5 primeiros casos
covid19PERosner$all.stats
