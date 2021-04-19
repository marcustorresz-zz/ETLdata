############# Atividade Semana 2 - Simulações e Sequências #############

?dnorm()

#Criando uma variável nomrmal
normal <- dnorm(4, mean = 0, sd = 1)

#Agora uma binomial
?dbinom() #nesse caso, a sintaxe é (n_quantiles, tamanho, probabilidade de ocorrer)
binomial <- dbinom(5, 10, 0.9)

#Variável de índice (?)
index <- c(1,2,3,4,5)
index[-1] #Retorna todos menos o da primeira posição