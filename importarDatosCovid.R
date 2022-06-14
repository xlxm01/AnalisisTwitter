#cargar las librerias
library(rtweet)
library(tidyverse)

###Importar datos covid19
tw = search_tweets(q = "covid19",
                   n = 10000)

#ver los datos
View(tw)

#te muestra estructura y algunos datos de tu dataframe
glimpse(tw)

#filtrar tweets en español
tw_es = tw %>% filter(lang == "es")

#contar cuantos tweets hay de cada usuario
#forma 1
tw_es %>%
  count(screen_name)%>%
  arrange(desc(n)) #ordenamos el que mas escribio primero
#forma 2
tw_es %>% 
  group_by(screen_name) %>%
  summarise(numero_ocurrencias = n())

#observamos en todos los tweets el q mas escribio
tw %>%
  count(screen_name)%>%
  arrange(desc(n))

view(tw_es)
