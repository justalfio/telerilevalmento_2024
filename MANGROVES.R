library(terra)
library(imageRy) #
library(ggplot2) #ggplot2 is a plotting package that provides helpful commands to create complex plots from data in a data frame
library(patchwork)
library(viridis)

#cambio directory
setwd("C:/Users/Utente/Desktop/TELERILEVAMENTO/mangroves 1")

# ad ogni banda noi assegneremo un'immagine
mng1 <- rast("mng1.tiff") #blue
mng2 <- rast("mng2.tiff") #green 
mng3 <- rast("mng3.tiff") #red
mng4 <- rast("mng4.tiff") #NIR

mng16 <- c(mng1, mng2, mng3, mng4) #creo il primo stack dei 4 layer del 2016
#inserisco la banda del NIR al posto della banda del Verde così da ottenere in verde ciò che è la foresta pluviale
im.plotRGB(mng16, 2, 4, 3) #inserisco la banda del NIR al posto della banda del Verde così da ottenere in verde ciò che è la foresta pluviale
 #VARIE PROVE

#assegno ad ogni immagine una banda per il 2021
mng5 <- rast("mng5.tiff") #blue
mng6 <- rast("mng6.tiff") #green
mng7 <- rast("mng7.tiff") #red
mng8 <- rast("mng8.tiff") #NIR

mng21 <- c(mng5, mng6, mng7, mng8) #creazione secondo stack con i 4 layer del 2021

#funzione par, unire le immagini
par(mfrow=c(1,2)) #creazione di un par per il confronto delle due immagini. 

# calcolo del DVI (difference vegetation index); utilizzo l'uguale perché è una operazione matematica
# si prende la banda del NIR e si esegue una sottrazione di pixel con la banda del Rosso
# se il risultato della sottrazione sarà alto allora quel pixel comprende una zona di vegetazione
#scelto le bande di
#The value range of the NDVI is -1 to 1. Negative values of NDVI (values approaching -1) correspond to water. Values close to zero (-0.1 to 0.1) generally correspond to barren areas of rock, sand, or snow. Low, positive values represent shrub and grassland (approximately 0.2 to 0.4), while high values indicate temperate and tropical rainforests (values approaching 1)
dvimng16 = mng16[[1]] - mng16[[4]] 
dvimng21 = mng21[[1]] - mng21[[4]]

#dopo aver calcolato dvi, primo plot per verificare differenze


