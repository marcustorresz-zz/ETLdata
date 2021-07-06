# Nos vídeos, vocês viram o exemplo com casos totais e novos casos. 
#Agora, o desafio de vocês é replicar isso com outra variável da base. (FIZ COM MORTES)

rm(list=ls())

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


if (!require('drc')) install.packages('drc'); library('drc')# pacote para predição



fitLL <- drm(deathsMS ~ dia, fct = LL2.5(), #Uso do deathMS
             data = covidPE, robust = 'mean') # fazendo a predição log-log com a função drm

plot(fitLL, log="", main = "Log logistic") # observando o ajuste

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) # usando o modelo para prever para frente, com base no vetor predDia
predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) # criando uma sequência de datas para corresponder aos dias extras na base de predição

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T) # juntando as informações observadas da base original 


if (!require('plotly')) install.packages('plotly'); library('plotly')# biblioteca para visualização interativa de dados

plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Casos - Predição") %>% add_trace(x = ~data, y = ~totalCases, name = "Casos - Observados", mode = 'lines') %>% layout(
  title = 'Predição de Mortes de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Mortes Acumuladas por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

if (!require('zoo')) install.packages('zoo'); library('zoo') # biblioteca para manipulação de datas e séries temporais

covidPE <- covidPE %>% mutate(deathsMM7 = round(rollmean(x = deathsMS, 7, align = "right", fill = NA), 2)) # média móvel de 7 dias

covidPE <- covidPE %>% mutate(deathsMSL7 = dplyr::lag(deathsMS, 7)) # valor defasado em 7 dias

plot_ly(covidPE) %>% add_trace(x = ~date, y = ~deathsMS, type = 'scatter', mode = 'lines', name = "Novos Casos") %>% add_trace(x = ~date, y = ~deathsMM7, name = "Novos Casos MM7", mode = 'lines') %>% layout(
  title = 'Novos Casos de COVID19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novos Casos por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

if (!require('xts')) install.packages('xts'); library('xts')  #análise para séries temporais
(covidPETS <- xts(covidPE$deathsMS, covidPE$date)) # transformar em ST
str(covidPETS)

autoplot(covidPETS)
acf(covidPETS)
