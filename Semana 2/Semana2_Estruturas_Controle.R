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
