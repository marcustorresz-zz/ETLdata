##################### ATIVIDADE Extração ########

#Desta vez, mostre que você entendeu o conceito de área intermediária e ambiente no R, 
#modificando o código para manter sinistrosRecifeRaw e a função naZero (ela pode ser útil no futuro!). 
#Além disso, indique qual dos objetos na área intermediária mais estavam usando memória do R. 

  

install.packages("janitor")
library(janitor) # para comparar os pacotes


#Primeiramente, vamos extrair os dados brutos dos anos 2019,2020 e 2021


sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')
sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

str(sinistrosRecife2019Raw)
str(sinistrosRecife2020Raw)
str(sinistrosRecife2021Raw)

#Em 2019, a variável data está em letra maiuscula
colnames(sinistrosRecife2019Raw)[1] <- "data"
sinistrosRecife2019Raw
# Agora, vamos juntas as bases
sinistrosRecifeRaw <- rbind(sinistrosRecife2020Raw,sinistrosRecife2021Raw)
sinistrosRecifeRaw <- rbind(sinistrosRecifeRaw,sinistrosRecife2019Raw) # como o numero de colunas n é igual, não dá para juntar todas.

#comparei aqui das 
compare_df_cols(sinistrosRecife2019Raw,sinistrosRecife2020Raw,sinistrosRecife2021Raw)

#Para juntar todas, a solução é usar o pacote dplyr com o join
library(dplyr)
sinistrosRecifeRaw <- full_join(sinistrosRecifeRaw, sinistrosRecife2019Raw)

# modifica natureza do sinistro e o bairro de texto para fator
class(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$bairro <- as.factor(sinistrosRecifeRaw$bairro)



# Tamanho de cada df

for (i in ls()) { 
  print(formatC(c(i, object.size(get(i))), 
                format="d", 
                width=30), 
        quote=F)
}


# O df mais pesado (e o mais importante) é o com todos os dados


rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))

zeros <- function(x) {
  
 x <- ifelse(is.na(x),0,x)
}

sinistrosRecifeRaw[,15:25] <- sapply(sinistrosRecifeRaw[,15:25], zeros)
#######################################
