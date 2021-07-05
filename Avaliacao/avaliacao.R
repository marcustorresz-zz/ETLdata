############### AVALIACAO #################


rm(list = ls())
if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require("dplyr")) install.packages('dplyr'); library('dplyr')
if (!require("tidyr")) install.packages('tidyr'); library('tidyr')
if (!require("reshape2")) install.packages('reshape2'); library('reshape2')
if (!require("fuzzyjoin")) install.packages('fuzzyjoin'); library('fuzzyjoin')


#Baixa a base de case

geral <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv') #Baixa o banco geral
pop <- fread("Avaliacao/tabela6579.csv", encoding = "UTF-8") #Baixa o banco de avaliação

####### TRATAMENTO E LIMPEZA ########

pop <- pop[-(1:5),] # Retira as cinco primeiras observações (sujeira)
pop <- pop %>% 
  filter(str_detect(V1,"(PE)")) %>%  # Seleciona oo Estado
  rename(municipio= V1,  pop= V2)  
  

pop$mun <- str_remove(pop$municipio, ' .(PE.)') # tirar o estado
pop$municipio <- toupper(pop$mun) #aumentar a palava
pop$municipio <- iconv(pop$municipio, from = 'UTF-8', to = 'ASCII//TRANSLIT') #tirar os acentos

head(pop)


#Calcule, para cada município do Estado, O total de casos confirmados e o total de óbitos 
#por semana epidemiológica atenção, você terá de criar uma variável de semana epidemiológica com base na data.

#A semana epidemiológica começa domingo e finaliza segunda. Como nosso primeiro caso começa em 04/01, a semana epidemiológica começa no dia 29/12/2019 
geral$semana_epidemio <- round(difftime(geral$dt_notificacao, "2019-12-29", units = "weeks"),0)
geral$tempo_obito <- round(difftime(geral$dt_notificacao, geral$dt_obito, units = "days"),0)

geral$obito <- ifelse(geral$tempo_obito >= 0, 1,0 ) # se houver uma data de óbito, mesmo com 0 dias, ele vai pegar
geral$obito[is.na(geral$obito)] <- 0
geral$obito_teste <- ifelse(geral$evolucao == "OBITO",1,0) #teste para ver se tem algum outlier

table(geral$classe)
head(geral)

#Ver os casos confirmados
geral$confirmados <- ifelse(geral$classe == "CONFIRMADO",1,0) #teste para ver se tem algum outlier



#4. Calcule a incidência (casos por 100.000 habitantes) e letalidade (óbitos por 100.000 habitantes) 
#por município a cada semana epidemiológica.

semana <- geral %>% 
              group_by(municipio, semana_epidemio) %>% 
              summarise(casos = n(), confirmados = sum(confirmados),  incidencia  = sum(confirmados)/100000, obitos = sum(obito), letalidade = sum(obito)/100000)  



#3. Enriqueça a base criada no passo 2 com a população de cada município, 
#usando a tabela6579 do sidra ibge.

final <- stringdist_join(semana, pop, by ="municipio")

write.csv(final, "Avaliacao/final.csv")

