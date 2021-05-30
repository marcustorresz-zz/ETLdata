############################ SEMANA 8 - DATA WRANGLING ######################




########## DESCOBERTA ###########
library(funModeling) 
library(tidyverse) 

glimpse(iris) # olhada nos dados
status(iris) # estrutura dos dados (missing etc)
freq(iris) # frequência das variáveis fator
plot_num(iris) # exploração das variáveis numéricas
profiling_num(iris) # estatísticas das variáveis numéricas

########## ESTRTURAÇÃO ###########

library(data.table)
library(dplyr)
library(tidyverse)

general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

latin_america_countries<-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela") # vetor que identifica países latino americanos

latin_america<- general_data %>% filter(location %in% latin_america_countries) # filtra casos apenas no vetor

mlatin <- latin_america %>% group_by(location) %>% mutate(row = row_number()) %>% select(location, new_cases, row) # cria matriz dos países, agrupando por local, criando uma nova linha com index e selecionando apenas algumas variáveis

# filtra dados para garantir que todos os países tenham mesmo nro de casos
result <- mlatin %>% group_by(location) %>% filter(row == max(row))
mlatin <- mlatin %>% filter(row<=min(result$row)) 



# pivota o data frame de long para wide
mlatinw <- mlatin %>% pivot_wider(names_from = row, values_from = new_cases) %>%
  remove_rownames %>% column_to_rownames(var="location") 

########## LIMPEZA ###########


library(data.table)
library(dplyr)
library(tidyverse)
library(funModeling) 

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela") # vetor que identifica países latino americanos

latin_america <- general_data %>% filter(location %in% latin_america_countries) # filtra casos apenas no vetor

latin_america <- latin_america %>% select(location, new_cases, new_deaths)

status(latin_america) # estrutura dos dados (missing etc)
freq(latin_america) # frequência das variáveis fator
plot_num(latin_america) # exploração das variáveis numéricas
profiling_num(latin_america) # estatísticas das variáveis numéricas

latin_america %>% filter(new_cases < 0)

########## ENRIQUENCIMENTO ###########
library(dplyr)
library(tidyverse)

baseCodMun <- read.table('bases_originais/base_codigos_mun.txt', sep = ',', header = T, encoding = 'UTF-8')

campusIES <- read.csv2('bases_originais/ies_georref.csv')

campusIES <- left_join(campusIES, baseCodMun, by = c('CO_MUNICIPIO' = 'id_munic_7'))



latin_america <- latin_america %>% filter(new_cases>=0)


########## VALIDAÇÃO ###########


library(data.table)
library(dplyr)
library(tidyverse)
library(validate)

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

# vetor que identifica países latino americanos
latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti",
                            "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela") 

latin_america <- general_data %>% filter(location %in% latin_america_countries) # filtra casos apenas no vetor

latin_america <- latin_america %>% select(location, new_cases, new_deaths)

regras_latin_america <- validator(new_cases >= 0, new_deaths >= 0)

validacao_latin_america <- confront(latin_america, regras_latin_america)

summary(validacao_latin_america)

plot(validacao_latin_america)