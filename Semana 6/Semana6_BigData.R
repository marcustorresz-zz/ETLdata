
################################## ATIVIDADE BIG DATA #############################################



# Compartilhe com a gente um código criado por você em que um large data é lido através da função ff. 
# Também mostre pelo menos duas operações estatísticas (média, mediana...) ou matemáticas básicas (soma, produto...), 
# e uma aplicação de estatística inferencial (regressão linear, X²...), usando uma amostra da base.

install.packages("data.table")
library(data.table)
casos= 5e6 # reduza os números antes e depois do e, caso esteja difícil de computar # mas tente manter pelo menos 1e6, para garantir o efeito se large data

#Fazer o banco
dadogrande = data.table(a=rpois(casos, 3),
                       b=rbinom(casos, 5, 0.1),
                       c=rnorm(casos, sd= 13),
                       d=sample(c("dmonica","cascao","cebolinha","magali"), casos, replace=TRUE),
                       e=rnorm(casos),
                       f=rpois(casos, 3),
                       g=pnorm(casos, mean = 1, sd =4)
)


object.size(dadogrande) # retorna o tamanho do objeto

head(dadogrande)


attach(dadogrande)


summary(dadogrande)
dadogrande$h <- a + b # algumas operações são possíveis diretamente
dadogrande$i <- a * b 


# Fiz o sample
sample <- dadogrande[sample(nrow(dadogrande), 240000) , ]

#regressão
lm(a ~ ., sample) # aí, funciona!!!
