###################### DATAS ########################


###### Introdução a Datas e Tempos ####

# Conversão para data
(str(minhaData1 <- as.Date(c("2015-10-19 10:15", "2009-12-07 19:15")) ) )
# Conversão é robusta até com lixo no dado
(str(minhaData2 <- as.Date(c("2015-10-19 Hello", "2009-12-07 19:15")) ) )

# Conversão para POSIXct
(str(minhaData3 <- as.POSIXct(c("2015-10-19 10:15", "2009-12-07 19:15")) ) )
unclass(minhaData3) # observamos o POSIXct no formato original (segundos)

# Conversão para POSIXlt
(str(minhaData4 <- as.POSIXlt(c("2015-10-19 10:15", "2009-12-07 19:15")) ) )
unclass(minhaData4) # observamos o POSIXlt no formato original (componentes de tempo)

### Extrações de Componentes
library(lubridate)

year(minhaData4) # ano

month(minhaData4) # mês

month(minhaData4, label = T) # mês pelo nome usando label = T

wday(minhaData4, label = T, abbr = T) # dia da semana abreviado

isoweek(minhaData4) # semana ISO 8601

epiweek(minhaData4) # semana epidemiológica

### Operações

(minhaSequencia <- seq(as.Date('2009-12-07 19:15'), as.Date('2015-10-19 10:15'), by = "day") ) # sequência usando a ideia de intervalo e de período

minhaData4 + minutes(90) # período

minhaData4 + dminutes(90) # duração

meuIntervalo <- as.interval(minhaData4[2], minhaData4[1]) # transforma em intervalo

now() %within% meuIntervalo  # investiga se está dentro do intervalo
table( (minhaSequencia + years(1) ) %within% meuIntervalo ) # observa se a frequência de casos da sequência 1 ano na frente que estão dentro do intervalo





#########DATAS  NA PRATICA #####


###
url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' # passar a url para um objeto
covidBR = read.csv2(url, encoding='latin1', sep = ',') # baixar a base de covidBR

covidPE <- subset(covidBR, state == 'PE') # filtrar para Pernambuco

str(covidPE) # observar as classes dos dados

covidPE$date <- as.Date(covidPE$date, format = "%Y-%m-%d") # modificar a coluna data de string para date

str(covidPE) # observar a mudança na classe

covidPE$dia <- seq(1:length(covidPE$date)) # criar um sequencial de dias de acordo com o total de datas para a predição

predDia = data.frame(dia = covidPE$dia) # criar vetor auxiliar de predição
predSeq = data.frame(dia = seq(max(covidPE$dia)+1, max(covidPE$dia)+180)) # criar segundo vetor auxiliar 

predDia <- rbind(predDia, predSeq) # juntar os dois 

library(drc) # pacote para predição

fitLL <- drm(totalCases ~ dia, fct = LL2.5(),
             data = covidPE, robust = 'mean') # fazendo a predição log-log com a função drm

plot(fitLL, log="", main = "Log logistic") # observando o ajuste

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) # usando o modelo para prever para frente, com base no vetor predDia
predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) # criando uma sequência de datas para corresponder aos dias extras na base de predição

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T) # juntando as informações observadas da base original 

library(plotly) # biblioteca para visualização interativa de dados

plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Casos - Predição") %>% add_trace(x = ~data, y = ~totalCases, name = "Casos - Observados", mode = 'lines') %>% layout(
  title = 'Predição de Casos de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Casos Acumulados por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

library(zoo) # biblioteca para manipulação de datas e séries temporais

covidPE <- covidPE %>% mutate(newCasesMM7 = round(rollmean(x = newCases, 7, align = "right", fill = NA), 2)) # média móvel de 7 dias

covidPE <- covidPE %>% mutate(newCasesL7 = dplyr::lag(newCases, 7)) # valor defasado em 7 dias

plot_ly(covidPE) %>% add_trace(x = ~date, y = ~newCases, type = 'scatter', mode = 'lines', name = "Novos Casos") %>% add_trace(x = ~date, y = ~newCasesMM7, name = "Novos Casos MM7", mode = 'lines') %>% layout(
  title = 'Novos Casos de COVID19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novos Casos por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

library #análise para séries temporais

(covidPETS <- xts(covidPE$newCases, covidPE$date)) # transformar em ST
str(covidPETS)

autoplot(covidPETS)
acf(covidPETS)