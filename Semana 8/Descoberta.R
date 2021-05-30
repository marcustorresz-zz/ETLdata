########## DESCOBERTA ###########
if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('funModeling')) install.packages('funModeling'); library('funModeling')
if (!require('siconvr')) install.packages('siconvr'); library('siconvr')
if (!require('datasets')) install.packages('datasets'); library('datasets')
if (!require('validate')) install.packages('validate'); library('validate')




glimpse(airquality) #verificar as informações das variáveis 
status(airquality) #Como podemos ver, Ozone e Solar.R possuem NA
freq(discoveries) # frequência dos factos
plot_num(airquality) # exploração das variáveis numéricas
profiling_num(airquality) # estatísticas das variáveis numéricas
