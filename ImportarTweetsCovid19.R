#cargar las librerias
library(rtweet) #Para importar tweets
library(tidyverse) #Para transformar datos mutate, filter, select
library(tidytext)#Para manejar texto unnest
library(tidyr) #Permite ordenar datos sucios

###Importar datos covid19
tw = search_tweets(q = "covid19",
                   n = 10000)

##otro ejemplo para importar
#tw_futbol = search_tweets(q = "futbol",
#                   n = 18000,
#                   lang = "es",
#                   include_rts = FALSE)



#ver los datos
View(tw)

#te muestra estructura, tipo d edatos y algunos datos de tu dataframe
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

#####Ejemplo filtrar una columna por id
#aux_tw = tw_futbol %>% filter(status.id = "36536") 

######hashtags mas comunes
#la columna hashtags es de tipo de dato lista
ht_mas_comunes = tw %>%
    select(hashtags)%>% #selecciono la columna hashtags
    unnest(hashtags)%>% #separa los elementos de una lista
    mutate(hashtags = toupper(hashtags))%>% #convierto la hashtags en mayusculas
    filter(!is.na(hashtags))%>% #filtra todos los hasgtags q no son NA (asi se coloca cuando el tweet no tiene ningun
    count(hashtags)%>% #rdo tabla con 2 columnas cuenta cunatas veces se repite las hashtags
    arrange(desc(n))%>% # ordenamos en forma descendiente
    head(20) #seleccione las 20 primeras, las mas usadas

#graficar
# 1. mapping
g = ggplot(ht_mas_comunes,
           mapping = aes(x = reorder(hashtags,n), #el eje x ordenado segun el valor de n, de menor a mayor
               y = n)) 

#2. agrego geometria con la funcion geom_bar para grafico de barra horizontales
#tabula la cantidad de veces que ocurre un evento. La altura de las barras representa el número de observaciones
g = g + geom_bar(stat = "identity") +
  coord_flip() #indico que las barras sean horizontales

#3. agrego etiquetas
g = g + labs(title = "Las 20 hashtags mas usadas",
             x = "hashtags",
             y = "nro de veces")
#veo grafico
g
