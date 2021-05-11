

########### SEMANA 5#########################




# extrair / carregar arquivos texto

# arquivos de texto com read.table
census_income <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", header = FALSE, sep = ',', dec = '.', col.names	= c('age', 'workclass', 'fnlwgt', 'education', 'education-num', 'marital-status', 'occupation', 'relationship', 'race', 'sex', 'capital-gain', 'capital-loss', 'hours-per-week', 'native-country', 'class')
)
# arquivos de texto com read.csv2
sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8'
)

# também é possível usar a função read.delim2
??read.delim2()
# arquivos de excel
install.packages('readxl')
library(readxl)

surveyCovidMun <- read_excel('bases_originais/Dataset_Port_and_Eng.xlsx', sheet=1) 

# arquivos json
install.packages('rjson')
library(rjson)

#CAPTA do json
empresasMetadados <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/eb9b8a72-6e51-4da2-bc2b-9d83e1f198b9/resource/b4c77553-4d25-4e3a-adb2-b225813a02f1/download/empresas-da-cidade-do-recife-atividades.json" )
#transforma em df
empresasMetadados <- as.data.frame(empresasMetadados)


# Um teste
empresaMetadados_teste <-  as.data.frame(fromJSON(file= "http://dados.recife.pe.gov.br/dataset/eb9b8a72-6e51-4da2-bc2b-9d83e1f198b9/resource/b4c77553-4d25-4e3a-adb2-b225813a02f1/download/empresas-da-cidade-do-recife-atividades.json" )) 
#por que não deu certo? Sintaxe?

# arquivos xml
install.packages('XML')
library(XML)

reedCollegeCourses <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/reed.xml")
 

#################
rm(list=ls())
############## I

##### Carga Incremental  ###############
#\### Nesse momento, verificamos se há um caso ou não####

library(dplyr)

# carrega base de dados original
chamadosTempoReal <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/079fd017-dfa3-4e69-9198-72fcb4b2f01c/download/sedec_chamados_tempo_real.csv', sep = ';', encoding = 'UTF-8')

#tirando uma linha, somente para fins comparativos entre o banco 1 e o 2, 
#já que não teve mundança nesse periodo da análise
chamadosTempoReal <- chamadosTempoReal[-3,]

# carrega base de dados para atualização, um novo
chamadosTempoRealNew <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/079fd017-dfa3-4e69-9198-72fcb4b2f01c/download/sedec_chamados_tempo_real.csv', sep = ';', encoding = 'UTF-8')

# compara usando a chave primária (no caso, é o numero do processo)
chamadosTempoRealIncremento <- (!chamadosTempoRealNew$processo_numero %in% chamadosTempoReal$processo_numero)
chamadosTempoRealIncremento
# compara usando a chave substituta
# criar a chave substituta. Margin 1 é coluna
chamadosTempoReal$chaveSubstituta = apply(chamadosTempoReal[, c(4,5)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

chamadosTempoRealNew$chaveSubstituta = apply(chamadosTempoRealNew[, c(4,5)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

# cria base de comparação
chamadosTempoRealIncremento <- (!chamadosTempoRealNew$chaveSubstituta %in% chamadosTempoReal$chaveSubstituta)

# comparação linha a linha
setdiff(chamadosTempoRealNew, chamadosTempoReal)

# retorna vetor com incremento
chamadosTempoReal[chamadosTempoRealIncremento,]

# junta base original e incremento
chamadosTempoReal <- rbind(chamadosTempoReal, chamadosTempoReal[chamadosTempoRealIncremento,])



############### WEB SCRAPPING ########
rm(list=ls())
# arquivos html
library(rvest)
library(dplyr)

# tabelas da wikipedia
url <- "https://pt.wikipedia.org/wiki/%C3%93scar"

urlTables <- url %>% read_html %>% html_nodes("table")

urlLinks <- url %>% read_html %>% html_nodes("link")

filmesPremiados <- as.data.frame(html_table(urlTables[5]))
filmesPremiados
# resultados do brasileirão

resultadosBrasileirao <- read_html("https://www.cbf.com.br")

resultadosBrasileirao <- resultadosBrasileirao %>% html_nodes(".swiper-slide")

rodada <- resultadosBrasileirao %>% html_nodes(".aside-header .text-center") %>% html_text()

resultados <- resultadosBrasileirao %>% html_nodes(".aside-content .clearfix")

mandante <- resultados %>% html_nodes(".pull-left .time-sigla") %>% html_text()

visitante <- resultados %>% html_nodes(".pull-right .time-sigla") %>% html_text()

tabelaBrasileirao <- data.frame(
  mandante = mandante,
  visitante = visitante,
  time = timestamp())

write.csv2(tabelaBrasileirao, 'tabelaBrasileirao.csv')
