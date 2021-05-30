########## Limpeza ###########
rm(list=ls())

#Compartilhe com a gente uma ampliação do código desta aula, em que você remove os NA (not available) presentes nos dados.

if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('funModeling')) install.packages('funModeling'); library('funModeling')
if (!require('siconvr')) install.packages('siconvr'); library('siconvr')
if (!require('datasets')) install.packages('datasets'); library('datasets')
if (!require('validate')) install.packages('validate'); library('validate')


general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela") # vetor que identifica países latino americanos

latin_america <- general_data %>% filter(location %in% latin_america_countries) # filtra casos apenas no vetor

latin_america <- latin_america %>% select(location, new_cases, new_deaths)

status(latin_america) # estrutura dos dados (missing etc)
freq(latin_america) # frequência das variáveis fator
plot_num(latin_america) # exploração das variáveis numéricas
profiling_num(latin_america) # estatísticas das variáveis numéricas

latin_america %>% filter(new_cases < 0)
latin_americaNA <- latin_america %>% drop_na()
