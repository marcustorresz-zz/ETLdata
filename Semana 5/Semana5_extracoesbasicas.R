################### ATIVIDADE - EXTRAÇÕES BÁSICAS ##############


####### Pacotes a serem baixados ######

install.packages('rjson') #Para extrair em JSON
install.packages('XML') # Para extrair em XML

library(rjson)
library(XML)

################# EXTRAÇÃO #########################


#Lista de Cursos da Washington State University, tirando da fonte XML
UWN <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/wsu.xml")

# Metadados da Prefeitura do Recife - Unidade Básica de Saúde, tirando em JSON
UBS <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/39d3ab40-573d-42e7-b96e-0cc051695391/resource/2f4e51bf-4aaf-47ef-ac4d-59690c685ecd/download/metadados-de-unidedes-basicas-saude.json" )
#transforma em df
UBS <- as.data.frame(UBS)


# Extrair os dados do excel em CSV. Esse não precisamos de um pacote, extraindo em CSV
alunos <- read.csv2("http://dados.recife.pe.gov.br/dataset/2015a954-4f3a-4ff2-84a1-f915feffd9ac/resource/6d9b3998-85fd-4c8a-9ec2-9932b9e5b90d/download/alunos.csv")


