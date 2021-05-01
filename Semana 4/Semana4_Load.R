############### Atividade Load ####################

# Vantagens e desvantagens

#Formato nativo: 
## Vantagens: É mais leve, ocupa menos espaço na RAM;
## Desvantagens: Geralmente não consegue ser lida por outros programas (Excel,Stata, Python...)

#Formato interoperável
## Vantagens: É passível de ser lido e operado em várias linguagens.
## Desvantagens: mais pesado, demora mais tempo para ser processado.

install.packages("microbenchmark") # para comparar os bancos
library(microbenchmark)

install.packages("readxl") # para ler em xls
library(readxl)

install.packages("writexl")
library(writexl)

# exporta em formato nativo do R (.rds)
saveRDS(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.rds")


## Interoperáveis ##

# exporta em formato tabular (.csv) 
write.csv2(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.csv")

write_xlsx(sinistrosRecifeRaw,"Semana 4/bases_tratadas/sinistrosRecife.xlsx")

# carrega base de dados em formato nativo R
sinistrosRecife <- readRDS('Semana 4/bases_tratadas/sinistrosRecife.rds')

# carrega base de dados em formato tabular (.csv) - padrão para interoperabilidade
sinistrosRecife <- read.csv2('Semana 4/bases_tratadas/sinistrosRecife.csv', sep = ';')

sinistrosRecife <- read_xlsx("Semana 4/bases_tratadas/sinistrosRecife.xlsx")


# compara os três bancos 

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.rds"), b <- write.csv2(sinistrosRecifeRaw, "Semana 4/bases_tratadas/sinistrosRecife.csv"),c<-write_xlsx(sinistrosRecifeRaw,"Semana 4/bases_tratadas/sinistrosRecife.xlsx")
, times = 30L)#O interessante nesse caso é que para salvar, o csv demorou mais que o xlsx, que é tecnicamente mais complexo

microbenchmark(a <- readRDS('Semana 4/bases_tratadas/sinistrosRecife.rds'), b <- read.csv2('Semana 4/bases_tratadas/sinistrosRecife.csv', sep = ';'),c <- read_xlsx("Semana 4/bases_tratadas/sinistrosRecife.xlsx"), times = 10L)
# A leitura se manteve como esperado. .xlsX apx 15 vezes mais lento

