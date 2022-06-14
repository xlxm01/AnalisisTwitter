getwd()

#Librerias que debes instalar
#install.packages("rtweet")

#cargar las librerias
library(rtweet)
library(tidyverse)
library(lubridate)

#para buscar ayuda en la consola escribes
#?seach_tweets, limite 18000 cada 15 minnutos

#parametros q :palabra que quiero buscar en los posteos de twitter, n:cantidad de datos a descargar por defecto es 100 max es 18000
tw_jonny = search_tweets(q = "Johnny Depp", 
                         n = 100)
#va a deribar a una pantalla del navegador y solicitar permisos a una cuenta de twitter 
View(tw_jonny)

#get_timeline: descarga la timeline (los tweets que un usuario ha creado) de los usuarios
#parametros: nombre de un usuario, limite de descargas 3200 tweets sin limite de fecha
#me da el tweet y algunas metricas osbre el
#?get_timeline
usuario = "RafaelNadal"
tl_rafa = get_timeline(user=usuario,
             n=100)
View(tl_rafa)

#get_followers: me devuelve la lista y ids de los seguidos de un usuario
#parametros: id del usuario , limite 75 mil usuarios cada 15 minutos
usuario = "rnadalacademy"
fl_nadalacademy = get_followers(user = usuario,
              n = 65000)
View (fl_nadalacademy)

#get_friends: devuelve ids de las personas que yo sigo. limite 5000 cada 15 minutos

friends_nadalacademy = get_friends(user = usuario,
                                   n = 300)
View(friends_nadalacademy)

#get_favorites: devuelve la lista de favoritos que marco un usuario 
#limite 3000 cantidad de favoritos, sin importar el periodo de tiempo
#?get_favorites

usuario = "RafaelNadal"
fv_nadal = get_favorites(usuario,
                         n = 1000)
View(fv_nadal)

#users_data: permite descargar datos de los usuarios
#localizacion, fecha creacion de cuenta, nro de seguidos, nro de amigos, nombre, 
#?users_data
us_data_nadal = users_data(fv_nadal)
View(us_data_nadal)

#contamos los favoritos de nadal
bdOrdenada = fv_nadal %>%
  count(screen_name)%>%
  arrange(desc(n))

###tidyng - ordenar
#guardar los 5 primeros con mas favoritos
top5 = fv_nadal %>%
  count(screen_name)%>%
  arrange(desc(n))%>%
  head(5)

###mapping
grafico = ggplot(data = top5,
                 mapping = aes(x = reorder(screen_name,n),
                               y = n)) 

###geometria de puntos
grafico = grafico + geom_point()

###labels
grafico = grafico + labs(title = "Usuarios favoritos de Rafa Nadal?",
                         y = "Cantidad de likes",
                         x = "Usuario de twiteer")
###dibujar
grafico

###geometria barra
grafico_bar = grafico_bar + geom_bar(stat = "identity", #igual a n
                                 fill = "red3") #rellena el area con un color

###labels
grafico_bar = grafico_bar + labs(title = "TPo 5 Usuarios favoritos de Rafa Nadal",
                         y = "Cantidad de likes",
                         x = "Usuario de twiteer")
###dibujar
grafico_bar + theme_bw()
grafico_bar + theme_classic()
grafico_bar + theme_dark()


####Numero de tweets favoritos por año
tw_es_por_anio = fv_nadal %>%
  mutate (fecha = ymd_hms(created_at)) %>%  #agrego una columna llamada fecha
  mutate (fecha = format(fecha, "%Y")) %>%  #cambia el formato se queda solo con año
  select (created_at, fecha) %>%  #selecciona las dos columnas
  count(fecha)%>%                    #cuenta o agrupa por mismo año
  ungroup()
#grafica  
graf_por_anio = ggplot(data = tw_es_por_anio,
                       mapping = aes(x = fecha,
                                     y = n))
#grafico de barras
graf_por_anio = graf_por_anio + geom_bar(stat = "identity",
                                         fill = "blue3")
graf_por_anio = graf_por_anio + labs(title = "Cant likes de Rafa Nadal",
                                     y = "Cant de likes",
                                     x = "Año")
graf_por_anio + theme_classic()

#grafico de lineas
graf_por_anio = ggplot(data = tw_es_por_anio,
                       mapping = aes(x = fecha,
                                     y = n,
                                     group = 1)) #soluciona error only one observation
                       
graf_por_anio = graf_por_anio + geom_line(col = "red3")
graf_por_anio = graf_por_anio + labs(title = "Favoritos por año",
                                     subtitle = "Rafa Nadal",
                                     y = "Cant de likes",
                                     x = "Año")
graf_por_anio
