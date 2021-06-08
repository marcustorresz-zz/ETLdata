# Compartilhe com a gente um código em que vocês cria uma estrutura de fatores.


rm(list= ls())

#criação do fator
fator <- factor(c("1", "3", "2", "1", "1", "3", "2", "3"))


#niveis do fator
levels(fator)


#colocar os labels nos fatores
recode <- c("alto" = 1, "médio" = 2, "baixo"= 3)

fator

(altura <- factor(fator, levels = recode, labels = names(recode)))
