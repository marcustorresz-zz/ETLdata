##### Semana 1 das Atividades de hugo###


#Um summary do Banco
summary(iris)

#plots do banco
plot(iris)

#estrutura do banco
str(iris)



#############OBJETOS E FUNÇÕES DO R ###############

c <- c(2, 3, 4, 5, 6) # Criando o vetor c
d <- c(-1,3,2,4,1) #criando o vetor d

#####Análises multivariadas####

#Correlação entre as variáveis 'c' e 'd'
cor(c,d)


#Regressão entre as mesmas variáveis

lm(c~d)
lm(d~c)


# Para ver a complexidade do banco, usar str(), como nesse caso abaixo

str(d)
