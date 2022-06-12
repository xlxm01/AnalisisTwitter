#cargar las librerias
library(rtweet)
library(tidyverse)

#importar datos covid19
tw = search_tweets(q = "covid19",
                   n = 10000)

#ver los datos
View(tw)

#te muestra estructura y algunos datos de tu dataframe
glimpse(tw)

#filtrar tweets en español
tw_es = tw %>% filter(lang == "es")

view(tw_es)
