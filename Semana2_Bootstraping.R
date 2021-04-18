############### Atividade - Bootstraping #########


#Criando um sample de 10 casos

sample(distNormalSimulacao, 10, replace = FALSE)

#Manter o seed 
set.seed(412)

#Usando a função replicate 100 vezes, do sample de 5
bootsDistNormal100 <- replicate(100, sample(distNormalSimulacao, 5, replace = TRUE)) # replicamos 10x a amostra, criando assim um bootstrapping
bootsDistNormal100

# calculando uma estatística com bootstrapping  (5 amostras)
mediaBootsNormal10 <-replicate(10, mean(sample(distNormalSimulacao, 5, replace = TRUE))) # calculamos a média de 10 amostras de 10 casos
mediaBootsNormal100 <-replicate(100, mean(sample(distNormalSimulacao, 5, replace = TRUE))) # calculamos a média de 50 amostras de 10 casos
mediaBootsNormal1000 <-replicate(1000, mean(sample(distNormalSimulacao, 5, replace = TRUE))) # calculamos a média de 100 amostras de 10 casos

# Comparando
mean(mediaBootsNormal10) # media do boostraping 10
mean(mediaBootsNormal100) # media do boostraping 100
mean(mediaBootsNormal1000) # media do boostraping 1000
mean(distNormalSimulacao) # media dos dados originais