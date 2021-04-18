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


##### Tipos de Objetos

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


