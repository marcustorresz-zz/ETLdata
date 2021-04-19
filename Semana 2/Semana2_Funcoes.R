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