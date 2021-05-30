########## ESTRTURAÇÃO ###########
rm(list=ls())

#Compartilhe com a gente um código em que você implementa um pivô long to wide ou iwde to long.


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
