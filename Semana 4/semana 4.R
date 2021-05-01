############# SEMANA 4 - ETL ##################

# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/etl1.R

#Essa linha de código mostra o processo de ETL completo


######### PRIMEIRA PARTE- Extração ############

#Extração via .csv


# carrega a base de snistros de transito do site da PCR
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

# junta as bases de dados com comando rbind (juntas por linhas (row))

sinistrosRecifeRaw <- rbind(sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# observa a estrutura dos dados
str(sinistrosRecifeRaw)
# modifca a data para formato date
class(sinistrosRecifeRaw$data) # como vcs podem ver, antes estava como character
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator
class(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)
#forma otimizada de ler caracter

# cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.csv")

#### Extração em Staging Area ####


#### Staging area e uso de memória

# ficamos com staging area??

ls() # lista todos os objetos no R

# vamos ver quanto cada objeto está ocupando

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

ls() # lista todos os objetos no R

# agora, vamos remover

gc() # uso explícito do garbage collector

rm(list = c('sinistrosRecife2020Raw', 'sinistrosRecife2021Raw'))

# deletando todos os elementos: rm(list = ls())
# deletando todos os elementos, menos os listados: 
rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))

saveRDS(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.csv")



#############################LOAD########
##########
install.packages("microbenchmark")
library(microbenchmark)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.csv")

# carrega base de dados em formato nativo R
sinistrosRecife <- readRDS('Semana 4/bases_tratadas/sinistrosRecife.rds')

# carrega base de dados em formato tabular (.csv) - padrão para interoperabilidade
sinistrosRecife <- read.csv2('Semana 4/bases_tratadas/sinistrosRecife.csv', sep = ';')

# compara os dois processos de exportação, usando a função microbenchmark

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.rds"), b <- write.csv2(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.csv"), times = 30L)

microbenchmark(a <- readRDS('Semana 4/bases_tratadas/sinistrosRecife.rds'), b <- read.csv2('Semana 4/bases_tratadas/sinistrosRecife.csv', sep = ';'), times = 10L)

