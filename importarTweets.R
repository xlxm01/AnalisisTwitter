getwd()

#Librerias que debes instalar
#install.packages("rtweet")

#cargar las librerias
library(rtweet)

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

#get_friends: devuelve ids de las personas que yo sigo

#get_favorites: devuelve la lista de favoritos que marco un usuario 
#limite 3200 cantidad de favoritos, sin importar el periodo de tiempo

#users_data: permite descargar datos de los usuarios
#localizacion, fecha creacion de cuenta, nro de seguidos, nro de amigos, nombre, 