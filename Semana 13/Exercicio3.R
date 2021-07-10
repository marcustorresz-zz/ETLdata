

##################### EXERCICIO 3 ##############################

########pacotes#######
rm(list=ls())

if (!require('data.table')) install.packages('data.table'); library('data.table')
if (!require('VIM')) install.packages('VIM'); library('VIM')
if (!require('Hmisc')) install.packages('Hmisc'); library('Hmisc')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require("drc")) install.packages('drc'); library('drc')
if (!require("plotly")) install.packages('plotly'); library('plotly')
if (!require("zoo")) install.packages('zoo'); library('zoo')


#1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html

covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')



#2. Corrija os NAs da coluna sintomas através de imputação randômica 

covid_sintomas <- covid19PE %>% setDT() #copiar base iris, usando a data.table

(covidNASeed <- table(covid_sintomas$sintomas)) # criamos 10 valores aleatórios

(covid_sintomas$sintomas[covidNASeed] <- NA) # imputamos NA nos valores aleatórios


??impute()

covid_sintomas$sintomas[covidNASeed] <- NA # recolocamos os NA

(covid_sintomas$sintomas <- impute(covid_sintomas$sintomas,"random")) # fazemos a imputação aleatória

#3. Calcule, para cada município do Estado, o total de casos confirmados e negativos

table(covid19PE$classe)


mun <- covid19PE %>% 
group_by(municipio,classe)%>%
 count(classe) %>% 
  filter(classe == "CONFIRMADO"|classe == "NEGATIVO")


#4. Crie uma variável binária se o sintoma inclui tosse ou não e calcule quantos casos confirmados e negativos tiveram tosse como sintoma


 head(covid19PE$sintomas)
 class(covid19PE$sintomas)
 
tosse <- "TOSSE"

covid19PE$tosse <-ifelse(grepl(tosse,covid19PE$sintomas),1,0)

tosse_sintoma <- covid19PE %>% 
  group_by(classe,tosse)%>%
  count(classe) %>% 
  filter(classe == "CONFIRMADO"|classe == "NEGATIVO")


#5. Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos

#Agregar por data de notificação
Estado <- covid19PE %>% 
  group_by(dt_notificacao)%>%
  count(classe) %>% 
  filter(classe == "CONFIRMADO"|classe == "NEGATIVO")


class(Estado$dt_notificacao) #verificar se class é date


Estado$dia <- seq(1:length(Estado$dt_notificacao)) # criar um sequencial de dias de acordo com o total de datas para a predição



predDia = data.frame(dia = Estado$dia) # criar vetor auxiliar de predição
predSeq = data.frame(dia = seq(max(Estado$dia)+1, max(Estado$dia)+180)) # criar segundo vetor auxiliar, criando 180 dias

predDia <- rbind(predDia, predSeq) # juntar os dois 



rm(list=ls()[! ls() %in% c("Estado","predDia")])


Estado_confirmado <- Estado %>% filter( classe == "CONFIRMADO")
Estado_negativo <- Estado %>% filter( classe == "NEGATIVO")


covidPE_confirmado <- Estado_confirmado  %>% mutate(newCasesMM7 = round(rollmean(x = n, 7, align = "right", fill = NA), 0)) # média móvel de 7 dias

covidPE_confirmado <- Estado_confirmado %>% mutate(newCasesL7 = dplyr::lag(n, 7)) # valor defasado em 7 dias

#Está dando um erro que não consegui resolver
# O newCasesMM7 não consegue ser criado

plot_ly(covidPE) %>% add_trace(x = ~dt_notificacao, y = ~n, type = 'scatter', mode = 'lines', name = "Novos Casos") %>% add_trace(x = ~date, y = ~newCasesMM7, name = "Novos Casos MM7", mode = 'lines') %>% layout(
  title = 'Novos Casos de COVID19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novos Casos por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação





