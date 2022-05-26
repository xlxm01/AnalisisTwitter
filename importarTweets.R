getwd()

#Librerias que debes instalar
#install.packages("rtweet")

#cargar las librerias
library(rtweet)

#para buscar ayuda en la consola escribes
#?seach_tweets

#parametros q :palabra que quiero buscar en los posteos de twitter, n:cantidad de datos a descargar por defecto es 100 max es 18000
tw_jonny = search_tweets(q = "Johnny Depp", 
                         n = 100)
View(tw_jonny)

