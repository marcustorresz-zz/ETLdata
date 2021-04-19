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
