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
