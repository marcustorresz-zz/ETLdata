##################### ATIVIDADE ETL REAL ########

#Desta vez, queremos que você mostre que entendeu o processo de ETL modificando um pouco a extração e o tratamento. 
#Ou seja: adicione mais ano de acidentes de trânsito à extração e lembre-se de uni-lo aos demais com o rbind; 
#depois, busque mais uma coluna para transformar em fator e acrescente isso ao código. 

install.packages("janitor")
library(janitor)
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
sinistrosRecifeRaw <- outer_join(sinistrosRecifeRaw, sinistrosRecife2019Raw)

# modifica natureza do sinistro e o bairro de texto para fator
class(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$bairro <- as.factor(sinistrosRecifeRaw$bairro)
