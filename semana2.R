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



