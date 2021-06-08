################### dplyr #############


rm(list=ls())
  if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('ade4')) install.packages('ade4'); library('ade4')

#Compartilhe com a gente um código criado por você com a aplicação de pelo menos um sumário, um agrupamento, uma manipulação de casos e uma manipulação de colunas

data <- as.data.frame( UCBAdmissions)

#sumário
count(data, Gender) 


#agrupamento

data %>% group_by(Dept) %>% summarise(avg = mean(Freq))

data$anom <- fct_anon(data$Dept) # anonimiza os fatores



#manipulação dos casos
data %>%  filter(Admit == "Admitted") %>% summarise(avg = mean(Freq))


# e de colunas
data %>% mutate(freqanom = Freq*as.numeric(anom)) %>% arrange(Gender, desc(freqanom)) # descendente

