#Compartilhe com a gente um código criado por você com uma shadow matrix 
# e um teste de aleatoriedade de valores ausentes. 



#Baixa os pacotes
if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require('funModeling')) install.packages('funModeling'); library('funModeling')
if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('readr')) install.packages('readr'); library('readr')



#atendimentos 2018 do SAMU recife
samu <- read_delim("http://dados.recife.pe.gov.br/dataset/e89dc8fc-642a-459a-83c2-048327088942/resource/d61c045c-1f68-49f7-aaf4-39fa5804d25d/download/ocorrencias2018.csv", 
                        ";", escape_double = FALSE, trim_ws = TRUE)


## identificando e removendo valores ausentes
status(samu) # estrutura dos dados (missing etc)
              # Muito NA na idade e no motivo final

# Complete-case analysis – listwise deletion

dim(samucompleto <- na.omit(samu)) #mudou muito


# Variação de Complete-case analysis – listwise deletion
dim(samucompleto <- samu %>% filter(!is.na(idade)))




x <- as.data.frame(abs(is.na(samu))) # cria a matrix sombra
head(x) # observa a matriz sombra

y <- x[which(sapply(x, sd) > 0)] # mantém apenas variáveis que possuem NA
cor(y) # observa a correlação entre variáveis
        # Há varias correlações altas, o que pode demonstrarum missing não randomico

cor(samu, y, use="pairwise.complete.obs") # busca padrões entre os valores específicos das variáveis e os NA
                                          # Não deu muito certo, provavelmente porque os dados não são numericos. Mesmo assim, podermos inferir a não randomicidade?

