################# Atividade - Calculando ##############

#Rodar 100 números aleatórios de 1 a 10
normal <- runif(100, 1, 10)
normal

#Tentar normalizar pela média
Normal <- normal - mean(normal)
Normal

#gráfico comparando os dois
par(mfrow=c(1,2))
hist(normal)
hist(Normal)
