#cargar las librerias
library(rtweet) #Para importar tweets
library(tidyverse) #Para transformar datos mutate, filter, select
library(tidytext)#Para manejar texto unnest
library(tidyr) #Permite ordenar datos sucios

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

#hashtags mas comunes
#la columna hashtags es de tipo de dato lista
ht_mas_comunes = tw %>%
    select(hashtags)%>% #selecciono la columna hashtags
    unnest(hashtags)%>% #separa los elementos de una lista
    mutate(hashtags = toupper(hashtags))%>% #convierto la hashtags en mayusculas
    filter(!is.na(hashtags))%>% #filtra todos los hasgtags q no son NA (asi se coloca cuando el tweet no tiene ningun
    count(hashtags)%>% #rdo tabla con 2 columnas cuenta cunatas veces se repite las hashtags
    arrange(desc(n))%>% # ordenamos en forma descendiente
    head(20) #seleccione las 20 primeras, las mas usadas

