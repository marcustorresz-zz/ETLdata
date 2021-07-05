####################### TEXT AS DATA ############

if (!require('fuzzyjoin')) install.packages('fuzzyjoin'); library('fuzzyjoin')

rm(list=ls())
######### juntando e buscando textos #####


# Exemplo universidade de princeton
baseA <- read.csv("http://www.princeton.edu/~otorres/sandp500.csv")
baseB <- read.csv("http://www.princeton.edu/~otorres/nyse.csv") 

# Advanced
baseC <- fuzzyjoin::stringdist_join(baseA, baseB, mode='left')
baseC <- fuzzyjoin::distance_join(baseA, baseB, mode='left')



######## FILTROS COM TEXTO #########
rm(list=ls())

if (!require('electionsBR')) install.packages('electionsBR'); library('electionsBR')
library(dplyr)
library(tidyr)

tse20 <- vote_mun_zone_local(year = 2020)

partidos_bolsonaro <- c("AVANTE", 'DC', "DEM", 'MDB', 'NOVO', 'PATRI', 'PL', 'PODE', 'PP', 'PROS', 'PRTB', 'PSC', 'PSD', 'PSDB', 'PSL', 'PTB', 'SD')

tse20A1 <- tse20 %>% filter(DESCRICAO_CARGO == 'Prefeito' & NUM_TURNO == 1)

tse20A1 <- tse20A1 %>% mutate(tag_partido = ifelse(grepl(paste(partidos_bolsonaro, collapse="|"), COMPOSICAO_LEGENDA), 'bolso_t1', 'nao_bolso_t1'))


