######################## Semana 2 ###############

#Funções no R - Linguagem funcional (INPUT (objetos + parâmetros) - FUNCTION - OUTPUT)
# Linguagem orientada a objeto

plot(iris)
plot(Titanic)

#mesmo plot, mas com saída é diferente

#Há metodos diferentes para cada tipo de dados, e para o mesmo input.
#De acordo com a propriedade, ele vai aplicar um método melhor aplicado.
methods(plot)

#Funções, objetos e estruturas no R.

library(dplyr) # permite seguências

#Linguagem estruturada

#Repetição (Do not repeat yourself)- DRY


#Bootstraping -  REPETIÇÃO DE AMOSTRAGEM.


#Indexação - Uma maneira de encontrar o dado no R. O operador básico
# são as chaves [] 


#sapply é uma estrutura vetorizada, por isso há algumas perdas, como o
#rótulo. O mappply() tenta solucionar alguns problemas


################## ATIVIDADES ####################


##### Tipos de Objetos########

# vetor 

vetor1 <- c(1,2,3,4,5,6) #função c (concatenar)

is.vector(vetor1) #testa se é vetor
typeof(vetor1) #tipo do vetor
class(vetor1) #classe
str(vetor1) #estrutura do objeto
length(vetor1) #Tamanho do objeto



#array (ou arranjo)  e´um vetor n dimensional 

array1 <- array(c(c('joao', 'luis', 'ana', 'claudia'), 21:24), 
                dim = c(2,2,2)) # cria array usando as funções array e c

is.array(array1) #testa se é array
typeof(array1) #tipo do array (no caso, character)
class(array1) #classe
str(array1) #estrutura do objeto
length(array1) #Tamanho do objeto

# arranjo de duas dimensões é uma matriz

matrix1 <- matrix (vetor1, nrow=2)

matrix1
is.array(matrix1) #testa se é matriz
typeof(matrix1) #tipo do matriz (no caso, character)
class(matrix1) #classe
str(matrix1) #estrutura do objeto
length(matrix1) #Tamanho do objeto


#lista (sequencia de objetos(listas, df...))

regCarros <- lm(mpg ~., mtcars) #criação de um modelo de regressão

regCarros
is.list(regCarros)
typeof(regCarros) #tipo de lista (no caso, character)
class(regCarros) #classe
str(regCarros) #estrutura da lista
length(regCarros) #Tamanho da lista

#dataframe

iris #df nativo

is.data.frame(iris)
typeof(iris) #tipo de df 
class(iris) #classe
str(iris) #estrutura do df
length(iris) #Tamanho do df


############# Criar o próprio df ######


#instalar eptools, da epidemio
install.packages("eeptools")
library(eeptools)

#vetor com o nome de alinos 
nomeAluno <- c("João", "José", "Luiz", "Maria","Ana","Olga")

#vetor com datas de nascimento
nascimentoAluno <- as.Date(c("1990-10-23","1992-03-21",
                             "1993-07-23","1989-07-23",
                           "1984-11-25","1985-11-15"))

#vetor com as idades
idadeAluno <- round(age_calc(nascimentoAluno, units='years'))
#não funciona por causa do eeptools   

install.packages("lubridate")
library(lubridate)
today <- as.Date(Sys.Date(), format='%d/%m/%y')

idadeAluno <- year(today) - year(nascimentoAluno) 
idadeAluno


#data frame com base nos vetores

listaAlunos <- data.frame(
  nome = nomeAluno,
  dataNasc = nascimentoAluno,
  idade = idadeAluno
)

listaAlunos

str(listAlunos)
############## Atividade - Data Frame  ###########


#vetor com o nome de árvores
nomeArvore <- c("Umbu", "Jacaranda", "Pau-Ferro", "Baobá","Pau-Brasil","Jaqueira")

#vetor com datas de plantio
nascimentoArvore <- as.Date(c("1920-11-02","1932-02-12",
                             "1967-02-01","1956-04-05",
                             "1948-05-23","1958-12-09"))

#vetor com as idades
today <- as.Date(Sys.Date(), format='%d/%m/%y')

idadeArvore <- year(today) - year(nascimentoArvore) 



listaArvore <- data.frame(
  nomeArvore = nomeArvore,
  dataNasc = nascimentoArvore,
  idade = idadeArvore
)

listaArvore


write.csv(listaArvore,"arvores.csv" ,row.names = FALSE)

#################### Simulações e Sequências #######################################
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/5_simulacoes_e_repeticoes_no_R.R 


# set.seed() configura a semente aleatória de geração de dados. Isso permite com que os resultados se mantenham constantes
# usando a função addTaskCallback deixamos a set.seed fixa, rodando no back

tarefaSemente <- addTaskCallback(function(...) {set.seed(123);TRUE}) # atribui a tarefa à variável tarefaSemente
#atribui a tarefa à variável aleatória
tarefaSemente # chama a tarefaSemente

# distribuição normal simulada
distNormalSimulacao <- rnorm(100) # usa a função rnorm para criar uma distribuição normal, indicando o total de casos

# a rnorm é a da memsa família da rbinom, que será vista abaixo. Para ver as outras, acesse o link https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/Distributions

summary(distNormalSimulacao) # sumário da distNormalSimulacao

# distribuição binomial simulada
distBinominalSimulacao <- rbinom(100, 1, 0.7) # rbinom para criar distribuição binominal, indicando casos, tamanho e probabilidade

?rbinom()
# a sintaxe aqui mostra que o primeiro numero é a quantidade de vezes. o segundo o tamanho (no caso, 0 ou 1, e o ultimo a probabilidade de sucesso)
distBinominalSimulacao
# EM ML é normal colocar a probabilidade em 0.7


# repetições, a função rep()
classeSimulacao <- c(rep("Jovem", length(distBinominalSimulacao)/2), rep("Jovem Adulto", length(distBinominalSimulacao)/2)) # vetor repetindo a classe Jovem 15x e Jovem Adulto 15x

# sequências

indexSimulacao <- seq(1, length(distNormalSimulacao)) # vetor com índex dos dados, usando a função length para pegar o total de casos

#Usar lenght é util para sempre referenciar o objeto anterior.



# por fim, podemos usar a função removeTaskCallback para remover a tarefa que criamos lá em cima

removeTaskCallback(tarefaSemente)


############# Atividade - Simulações e Sequências #############

?dnorm()

#Criando uma variável nomrmal
normal <- dnorm(4, mean = 0, sd = 1)

#Agora uma binomial
?dbinom() #nesse caso, a sintaxe é (n_quantiles, tamanho, probabilidade de ocorrer)
binomial <- dbinom(5, 10, 0.9)

#Variável de índice (?)
index <- c(1,2,3,4,5)
index[-1] #Retorna todos menos o da primeira posição





############### Bootstraping ##########
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/6_amostragem_e_boostrapping.R

#OBJETIVO: NÃO ENVIESAMENTO DO MODELO DE MACHINHE LEARNING 

# amostragem sem reposição usando função sample
#15 é o numero de casos da amostra
sample(distNormalSimulacao, 15, replace = FALSE) # se você não tiver o objeto distNormalSimulacao no seu ambiente, crie com o script anterior

# amostragem com reposição usando função sample
sample(distNormalSimulacao, 15, replace = TRUE)

# bootstraping com função replicate
set.seed(412) # agora, não vamos mais usar como tarefa mas como execução ponto a ponto

#Replicar a amostra 10 vezes, com tamanho 10
bootsDistNormal10 <- replicate(10, sample(distNormalSimulacao, 10, replace = TRUE)) # replicamos 10x a amostra, criando assim um bootstrapping
bootsDistNormal10

# calculando uma estatística com bootstrapping (10 amostras)
mediaBootsNormal10 <-replicate(10, mean(sample(distNormalSimulacao, 10, replace = TRUE))) # calculamos a média de 10 amostras de 10 casos
mediaBootsNormal50 <-replicate(50, mean(sample(distNormalSimulacao, 10, replace = TRUE))) # calculamos a média de 50 amostras de 10 casos
mediaBootsNormal100 <-replicate(100, mean(sample(distNormalSimulacao, 10, replace = TRUE))) # calculamos a média de 100 amostras de 10 casos

# vamos comparar???
mean(mediaBootsNormal10) # media do boostraping 10
mean(mediaBootsNormal50) # media do boostraping 50
mean(mediaBootsNormal100) # media do boostraping 100
mean(distNormalSimulacao) # media dos dados originais

# partições
install.packages('caret', dependencies = T) # caret é um pacote geral de machine learning # se já tiver não, innstale =D
library(caret)

# primeiro, criamos as partições de dados
particaoDistNormal <- createDataPartition(1:length(distNormalSimulacao), p=.7) # passamos o tamanho do vetor e o parâmetro de divisão

treinoDistNormal <- distNormalSimulacao[unlist(particaoDistNormal)] # criamos uma partição para treinar os dados, usando a partição anterior. Atenção: o comando unlist é muito usado para transformar uma lista num vetor

testeDistNormal <- distNormalSimulacao[- unlist(particaoDistNormal)] # criamos uma partição para testar os dados, usando a partição anterior. Atenção: o comando unlist é muito usado para transformar uma lista num vetor


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


##################### CALCULANDO ################
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/6_amostragem_e_boostrapping.R

# o R como calculadora

#Na distribuição binomial, as probabilidades são independentes e constantes. Cada tentativa é uma prova de Bernoulli (somente podem ocorrer dois possiveis resultados)
# Foco no sucesso obtidos em n tentativas
binomialnegSimulacao <- rnbinom(300, mu = 3, size = 10) #300 casos,dispersão de 3 e tamanho de 10 
binomialnegSimulacao


#Na distribuição de poission, a probabilidade de um evento ocorrer é independente e a mesma 
# do ultimo que ocorreu.
# foco no numero de sucessos durante um intervalo continuo
poissonSimulacao <- rpois(300, 3)
poissonSimulacao


hist(binomialnegSimulacao)
hist(poissonSimulacao)

binomialnegSimulacao + poissonSimulacao # soma as distribuições

poissonSimulacao + 100 # soma 100 a cada elemento

poissonSimulacao^2 # eleva ao quadrado

poissonSimulacao * binomialnegSimulacao # multiplica

round(distNormalSimulacao, 0) # arredonda o vetor para inteiros

ceiling(distNormalSimulacao) # arredonda para cima

floor(distNormalSimulacao) # arredonda para baixo

distNormalSimulacao %% poissonSimulacao # módulo dos vetores

# também podemos usar funções estatísticas no R

# média
mean(poissonSimulacao)
mean(binomialnegSimulacao)

# mediana
median(poissonSimulacao)
median(binomialnegSimulacao)

# desvio padrão
sd(poissonSimulacao)
sd(binomialnegSimulacao)

# variância
var(poissonSimulacao)
var(binomialnegSimulacao)

# uma aplicação prática?? vamos centralizar (normalizar) a nossa simulação poisson
poissonSimulacaoCentral <- poissonSimulacao - mean(poissonSimulacao)
hist(poissonSimulacao)
hist(poissonSimulacaoCentral)


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


################# INDEXAÇÃO #####################
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/8_indexacao.R


# vetores
poissonSimulacao[1] # acessa o primeiro elemento
poissonSimulacao[c(1:10, 15)] # acessa os elementos 1, 2 até 10 e 15

# matrizes
matrix1[1, ] # linha 1
matrix1[ ,1] # coluna 1
matrix1[1,1] # linha 1, coluna 1

# data.frames
iris$Species # retorna apenas a coluna species do data.frame iris

iris[ , 5] # retorna todas as linhas apenas a coluna species do data.frame iris

iris[1:10, 2:5] # retorna as 10 primeiras linhas das colunas 2 a 5 do data.frame iris

iris[, 'Species'] # retorna a coluna espécies, indexada pelo nome

iris[, 'Species', drop = FALSE] # retorna a coluna espécies, indexada pelo nome, em formato de coluna

iris[ , -5] # retorna todas as colunas, menos a 5 - espécies

# listas, todos com a mesmo objetivo
regCarros$coefficients
regCarros$coefficients[1] #apenas o primeiro coeficiente
regCarros[['coefficients']][1]
regCarros[[1]][1]

# usando operadores lógicos
a <- 5
b <- 7
c <- 5

a < b
a <= b
a > b
a >= b
a == b
a != b

a %in% c(b, c) # a é igual a 5
a == c & a < b
a != c | a > b
xor(a != c, a < b) #ou EXCLUSIVO (ou ou)
!a != c
any(a != c, a < c, a == c) # qualquer condição é vdd?
all(a != c, a < c, a == c) # todas as condiçoes sao vdd?

# operadores lógicos na prática
iris$Sepal.Length <= 0 # testa se os valores na sepal.length são menores ou iguais a 0 

iris$Sepal.Length >= 0 & iris$Sepal.Width <= 0.2 # testa se, numa dada linha, os valores na sepal.length são menores ou iguais a 0 OU se os valores em sepal.width são iguais ou menores que 0.2

which(iris$Sepal.Length <= 5) # a função which mostra a posição (as linhas) em que a condição é atendida

match(iris$Species, 'setosa') # também é possível usar a função match para encontrar a correspondência entre dados ou objetos


############################# Atividade - Indexação ####################

#Aqui, vou usar o df airquality do R

airquality

airquality$Ozone #retornar a variável Ozone
airquality[,1] #Outra maneira de retornar a variável Ozone, que está na posição 1
airquality[1,] #Retorna a primeira linha
airquality[1:3,1:3] #retorna um 3x3
airquality[, 'Wind'] #retorna nominalmente a variable Wind

#Operadores lógicos

airquality$Wind > 0 #retorna uma boolean de todos os casos se são maiores que 0 ou não

airquality$Wind == 10.3 #ou se é igual a um número

airquality$Wind == 10.3 & airquality$Month == 10 #ou se é de algum mes e igual ao numero
airquality$Wind == 10.3 | airquality$Month == 10 #ou um ou outro
xor(airquality$Wind == 10.3,airquality$Month == 10) #ou exclusivo
any(airquality$Wind == 10.3,airquality$Month == 10) # se há algum que possui
all(airquality$Wind == 10.3,airquality$Month == 10) # se todos possuem
10.3 %in% airquality$Wind # se esse numero está contido



################# ESTRUTURAS DE CONTROLE #####################
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/9_estruturas_de_controle.R



#estrutura condicional

x <- runif(1, 0, 5)  #criar um caso entre 0 e 5 num modelo uniforme
x

if(x > 3) {
  y <- 5
} else {
  y <- 0
}
y

# avaliação condicional simples
irisCopia <- as.data.frame(iris)
irisCopia$SpeciesDummy <- ifelse(irisCopia$Species == 'setosa', 1, 0)

# estrutura de repetição
par(mfrow = c(2, 2)) # prepara a tela de gráficos como uma matriz 2x2 para receber os 4 gráficos gerados abaixo

for (i in 1:4) { # cria o loop, que deve ir de 1 a 4
  x <- iris[ , i] # atribui as colunas da base de dados a uma variável temporária
  hist(x,
       main = paste("Variável", i, names(iris)[i]), # atribui o nome ao gráfico de forma incremental, passando coluna por coluna
       xlab = "Valores da Variável", # rótulo do eixo x
       xlim = c(0, 10)) # limite mínimo e máximo do eixo x
}

#o lapply faz o mesmo
lapply(iris[, 1:4], hist)


################## Atividade - Estruturas de Controle #########

# Ainda usando o df airquality, primeiro farei uma condicional e depois uma repetição

airquality$tempMean <- ifelse(airquality$Temp > mean(airquality$Temp), "hot", "cold") #Aqui, quero saber se o dia foi mais quente que a média.
airquality$tempMean

#criando o histograma com repetição
par(mfrow = c(2, 2))


for (i in 1:4) { 
  x <- airquality[ , i] #Pega cada coluna de 1 a 4
  hist(x,
       main = paste("Histograma de", names(airquality)[i]), #Adeque a legenda como necessário
       xlab = "Valores" 
    )
}






################  FUNÇOES #####################
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/10_funcoes.R

# função
f <- function() {
  cat("Hello, world!\n")
}
f()

# função com estrutura de repetição
f <- function(nro) {
  for(i in 1:nro) {
    cat("Hello, world!\n")
  }
}
f(3)

# função com estrutura condicional e de repetição
f <- function(nro) {
  if(nro < 100) {
    for(i in 1:nro) {
      cat("Hello, world!\n")
    }
  } else {
    cat("Tá de brincadeira imprimir isso tudo")
  }
}
f(99)
f(100)

# agora, uma função mais útil...
centralizacao <- function(x) {
  x <- x - mean(x)
  return(x) #o return serve para retornar a função mesmo 
}

centralizacao(irisCopia$Sepal.Length)

centralizacao <- function(x) {
  x <- x - mean(x)
}

centralizacao(irisCopia$Sepal.Length)
centroTeste <- centralizacao(irisCopia$Sepal.Length)




########################### Atividade - Funções ####################


calor <- function(x){
  if (x > 23 ) {
    for(i in 1:4) {
      plot(airquality[,i])
    }
} else {
  for(i in 1:4) {
  plot(iris[,i])
}}
}

calor(20)
calor(40)


rm(list=ls())

################  FUNÇÕES DE REPETIÇÃO - APPLY  #####################
# É importante deixar claro que essa parte foi copiada do script do Professor Hugo,
# disponível em: https://github.com/hugoavmedeiros/etl_com_r/blob/master/scripts/11_funcoes_de_repeticao.R


# funções de repetição - família apply

# média de cada variável do data frame iris
apply(iris[ ,-5], 2, mean) # iris[,-5] retira a última coluna, que não é numérica. no segundo parâmetro, 
                          # o 2 indica que queremos a média das colunas. 
lapply(iris[, -5], mean) # Cria uma lista. A sintaxe é mais simples, pois não precisa especificar se é coluna ou linha
sapply(iris[, -5], mean) # Gera o resultado como verto . Mesma sintaxe, sendo a principal diferença que a sapply sempre tenta simplificar o resultado. 
                          #Há uma aplicação de forma vetorizada

par(mfrow = c(2, 2)) # prepara a área de plotagem para receber 4 plots

sapply(iris[ , 1:4], hist)
mapply(hist, iris[ , 1:4], MoreArgs=list(main='Histograma', xlab = 'Valores', ylab = 'Frequência')) # mapply tem a vantagem de aceitar argumentos da função original

for (i in 1:4) { # cria o loop, que deve ir de 1 a 4
  x <- iris[ , i] # atribui as colunas da base de dados a uma variável temporária
  hist(x,
       main = names(iris)[i], # atribui o nome ao gráfico de forma incremental, passando coluna por coluna
       xlab = "Valores da Variável", # rótulo eixo x
       ylab = 'Frequência', # rótulo eixo y
       xlim = c(min(iris[, i]), max(iris[, i]))) # limites do eixo x
}

########### Atividade - Funções de Repetição #####

#Vou usar o banco airquality

apply(airquality,2,mean, is.na = F) # a média das variáveis
sapply(airquality,mean) # a média das variáveis de outra maneira

#### Graficos de Histograma


# Unsando sapply
sapply(airquality[,1:4], hist)

#usando mapply
mapply(hist, airquality[ , 1:4], MoreArgs=list(main='Histograma', xlab =  'Valor', ylab = 'Número de casos')) 


#Usando for
for (i in 1:4) { 
  x <- airquality[ , i] 
  hist(x,
       main = paste("Histograma de", names(airquality)[i]), #Adeque a legenda como necessário
       xlab = "Valores" 

  )
}
