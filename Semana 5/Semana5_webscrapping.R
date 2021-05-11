########## Atividade webscrapping ############

rm(list=ls())
########################################

#Aqui, vou tentar pegar informações dos prefeitos de Floresta (PE)

url <- "https://pt.wikipedia.org/wiki/Floresta_(Pernambuco)"

urlTables <- url %>% read_html %>% html_nodes("table")

urlLinks <- url %>% read_html %>% html_nodes("link")

Pref <- as.data.frame(html_table(urlTables[6]))
Pref
