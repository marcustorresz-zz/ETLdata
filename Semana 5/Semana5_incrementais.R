################### ATIVIDADE - CARGAS INCREMENTAIS ##############
rm(list=ls())

#Nessa atividade, vou usar os dados dos alunos de 2020 da Prefeitura do Recife.


#Carrega a base de dados dos alunos 
alunos <- read.csv2("http://dados.recife.pe.gov.br/dataset/2015a954-4f3a-4ff2-84a1-f915feffd9ac/resource/6d9b3998-85fd-4c8a-9ec2-9932b9e5b90d/download/alunos.csv")

# Como essa base não se atualiza momento a momento, vou, assim como na atividade do professor, apagar as duas primeiras linhas

alunos <- alunos[-(1:3),]

#Baixando de novo, mas com outro nome
alunosAtual <- read.csv2("http://dados.recife.pe.gov.br/dataset/2015a954-4f3a-4ff2-84a1-f915feffd9ac/resource/6d9b3998-85fd-4c8a-9ec2-9932b9e5b90d/download/alunos.csv")


#Aqui vamos comparar usando a chave. Nesse caso, a variável é o ID_ALUNO
alunosdif <- (!alunos$ID_ALUNO %in% alunosAtual$ID_ALUNO)
alunosdif


#Agora vamos criar a chave substituta. Nesse caso, vamos usar o ano,ID de Martrícula, Mes e ano

alunos$chaveSub = apply(alunos[, c(1,3,4,5)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

alunosAtual$chaveSub = apply(alunosAtual[, c(1,3,4,5)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

#Comparando a chave
alunosdifChave <- (!alunos$chaveSub %in% alunosAtual$chaveSub)
alunosdifChave


#Comparando em cada linha
#Por que se for o contrario mostra as linhas
setdiff(alunosAtual, alunos)

# retorna vetor do antigo com incremento
alunos[alunosdif,]

# junta as base antiga e o adicional
alunosNew <- rbind(alunos, alunos[alunosdif,])
