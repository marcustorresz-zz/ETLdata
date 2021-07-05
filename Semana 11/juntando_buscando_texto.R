#Compartilhe com a gente um código criado por você em que você junta duas bases por nomes não categorizados e, em seguida, realiza uma busca por determinados textos em uma das colunas. Atenção: a base de dados pode ser simulada! 
#  não precisa ser real.


if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require("dplyr")) install.packages('dplyr'); library('dplyr')
if (!require("tidyr")) install.packages('tidyr'); library('tidyr')
#if (!require("reshape2")) install.packages('reshape2'); library('reshape2')
if (!require("fuzzyjoin")) install.packages('fuzzyjoin'); library('fuzzyjoin')
if (!require("lubridate")) install.packages('lubridate'); library('lubridate')


#Baixa a base de case

geral <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv') #Baixa o banco geral
pop <- fread("Avaliacao/tabela6579.csv", encoding = "UTF-8") #Baixa o banco de avaliação



######limpeza

pop <- pop[-(1:5),] # Retira as cinco primeiras observações (sujeira)
pop <- pop %>% 
  filter(str_detect(V1,"(PE)")) %>%  # Seleciona oo Estado
  rename(municipio= V1,  pop= V2)  
pop$mun <- str_remove(pop$municipio, ' .(PE.)') # tirar o estado
pop$munic <- toupper(pop$mun) #aumentar a palava
pop$municipio <- iconv(pop$munic, from = 'UTF-8', to = 'ASCII//TRANSLIT') #tirar os acentos

semana <- geral %>% 
  group_by(municipio) %>%  #Merge por semana e municipio
  #Soma dos casos e calculo de incidencia e letalidade
  summarise(casos = n())  




final <- stringdist_join(semana, pop, mode="left") # faz o teste
finaldist <- distance_join(semana, pop) # faz o teste
