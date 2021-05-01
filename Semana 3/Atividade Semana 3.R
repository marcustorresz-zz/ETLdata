######################### ATIVIDADE SEMANA 3 (ASSÍNCRONA) ####################


# 1. Crie um data frame com pelo menos 500 casos e a seguinte composição: duas variáveis normais de desvio padrão diferente, 
# uma variável de contagem (poisson), uma variável de contagem com dispersão (binomial negativa), uma variável binomial (0,1), 
# uma variável qualitativa que apresenta um valor quando a variável binomial é 0 e outro quando é 1, e uma variável de index. 


?rnbinom()
??binomial
rm(list=ls())

set.seed(12) #configurando a semente    

#Criando as variáveis 
  normal1 <- rnorm(500, mean = 1, sd = 4)  #A primeira normal, com 500 casos, média 1 e desvio padrão 4
  normal2 <- rnorm(500, mean = 12, sd = 1)  #A primeira normal, com 500 casos, média 12 e desvio padrão 1 
  poisson <- rpois(500, 0.5) # A variável de poisson, com 500 casos, e o lambida 0.5 (vetor de médias não negativas). Nesse, o type é integral.
  negbinomial <- rnbinom(500, prob = 0.3, size = 100) # Na binomial negativa, 500 casos, probabilidade de 0.3 (pode-se usar o mu também, que usa a média, e tamannho é o numero de sucessos)
  binomial <- rbinom(500, 1, 0.3) #A variável binomial (0,1), com 500 casos, número de tentativas e a probablidade de sucesso (30%)
  quali <- ifelse(binomial == 1, T,F) #Condicional. Quando for um é vdd
  index <- normal1 - normal2 > normal2- normal1 # Se a diferneteça de normal 1 e 2 é maior que o contrário
  
  
  df <- data.frame(
    normal1,normal2, poisson, negbinomial, binomial, quali, index
  )
  

  #rm(list = setdiff(ls(), "df")) # retirar todos menos o df

# As variáveis (normais, contagem e binomial) devem ser simuladas!!! ok
  
#2. Centralize as variáveis normais. 
  
#Uma maneira é usando a função
  
  f <- function(n) {
    if(n < 3) { 
      for(i in 1:n) {
      x <-  df[,i] - mean(df[,i]) #faz o cálculo
        return(x)
      }
    } else {
      cat("Não é variável normal")
    }
  }
  
  
  f(1)
  f(2)
  f(3) # Aqui retorna que não é porque sómente as duas primeiras são as normais 
  
  #Ou somente fazer a conta

normal1 <- df$normal1 - mean(df$normal1)
normal2 <- df$normal2 - mean(df$normal2)



#3. Troque os zeros (0) por um (1) nas variáveis de contagem. 
  ifelse(df$binomial == 0,1,1)
  ifelse(df$negbinomial == 0,1,1)

  #4. Crie um novo data.frame com amostra (100 casos) da base de dados original. 
??sample
  
  sampledf <- df[sample(1:nrow(df), 100),]
  