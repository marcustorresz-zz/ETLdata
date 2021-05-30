############################### Validação ####################
rm(list=ls())

#Compartilhe com a gente uma aplicação de validação, com criação de regras pertinentes à base de dados que você estiver utilizando.

if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('funModeling')) install.packages('funModeling'); library('funModeling')
if (!require('siconvr')) install.packages('siconvr'); library('siconvr')
if (!require('datasets')) install.packages('datasets'); library('datasets')
if (!require('validate')) install.packages('validate'); library('validate')
if (!require('rvest')) install.packages('rvest'); library('rvest')
if (!require('stringi')) install.packages('stringi'); library('stringi') #para ajeitar as variáveis com acento
if (!require('validate')) install.packages('validate'); library('validate') #para fazer a validação



#cadastro das escolas da prefeitura do recife
cad <- read.csv2("http://dados.recife.pe.gov.br/dataset/e9c0d2a3-9f5d-4a4e-815d-66c2e736c7e5/resource/bb8b70d4-4204-40d3-bc77-409a1651b8b9/download/escolas2015.csv")

#Ver os dados

glimpse(cad) # olhada nos dados
status(cad) # estrutura dos dados (missing etc)
freq(cad) # frequência das variáveis fator
plot_num(cad) # exploração das variáveis numéricas
profiling_num(cad) # estatísticas das variáveis numéricas



#Iremos depois pegar as variáveis::
# Total de Funcionários
#Nome da Escola
#Bairro

#Selecionar as variáveis de interesse

local <- cad %>% select( nome,bairro, total_funcionarios) %>%
  group_by(bairro) %>%
  summarise(
    fun = sum(total_funcionarios),
    num_esc = n()
  )

#pivotar
bairro <- local %>% pivot_wider(names_from = bairro, values_from = fun)
rm(bairro)

#Refazer o processo
glimpse(local) # olhada nos dados
status(local) # estrutura dos dados (missing etc)
freq(local) # frequência das variáveis fator
plot_num(local) # exploração das variáveis numéricas
profiling_num(local) # estatísticas das variáveis numéricas






??html_nodes
#Aqui, vou tentar pegar informações  de alguns bairros do recife

url <- "https://pt.wikipedia.org/wiki/Lista_de_bairros_do_Recife"

urlTables <- url %>% read_html %>% html_nodes("table")

urlLinks <- url %>% read_html %>% html_nodes("link")

bairro <- as.data.frame(html_table(urlTables[3]))

bairro$bairro <- toupper(bairro$X1)

bairro$bairro <- stri_trans_general(bairro$bairro, "Latin-ASCII")

#ver os joins
local_bairro_inner <- inner_join(bairro, local, by = "bairro")
local_bairro_left <- left_join(bairro, local, by = "bairro")
local_bairro_right <- right_join(bairro, local, by = "bairro")



##################### validação ##################
#vou fazer aqui com o right

#Substituir a vírgula pelo ponto
local_bairro_right$X2 <- as.numeric(gsub(",", ".", gsub("\\.", "", local_bairro_right$X2)))
local_bairro_right$X3 <- as.numeric(gsub(",", ".", gsub("\\.", "", local_bairro_right$X3)))
local_bairro_right$X4 <- as.numeric(gsub(",", ".", gsub("\\.", "", local_bairro_right$X4)))
local_bairro_right$X5 <- as.numeric(gsub(",", ".", gsub("\\.", "", local_bairro_right$X5)))
local_bairro_right$X6 <- as.numeric(gsub(",", ".", gsub("\\.", "", local_bairro_right$X6)))

local_bairro_right_validate <- local_bairro_right %>% validator( x2>= 0, x3 >= 0, x4 >= 0, x5 >= 0, x6 >= 0, fun >= 0, num_esc >=0)

validacao_latin_america <- confront(local_bairro_right, local_bairro_right_validate)

summary(validacao_latin_america)

plot(validacao_latin_america)
