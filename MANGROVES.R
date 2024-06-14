library(terra)
library(imageRy)
#cambio directory
setwd("C:/Users/Utente/Desktop/TELERILEVAMENTO")

# ad ogni banda noi assegneremo un'immagine
mng1 <- rast("mng1.tiff") #blue
mng2 <- rast("mng2.tiff") #green 
mng3 <- rast("mng3.tiff") #red
mng4 <- rast("mng4.tiff") #NIR

mng16 <- c(mng1, mng2, mng3, mng4) #creo il primo stack dei 4 layer del 2016
#visualizzazione della banda NIR in verde
im.plotRGB(mng, 1, 4, 3)
im.plotRGB(mng, 1, 2, 3)
 im.plotRGB(mng, 4, 2, 3)
 im.plotRGB(mng, 1, 4, 3)
 im.plotRGB(mng, 3, 1, 4)
 im.plotRGB(mng, 1, 4, 3)
im.plotRGB(mng, 2, 4 , 3)
 im.plotRGB(mng, 2, 1, 3)  #VARIE PROVE

#assegno ad ogni immagine una banda per il 2021
mng5 <- rast("mng5.tiff") #blue
mng6 <- rast("mng6.tiff") #green
mng7 <- rast("mng7.tiff") #red
mng8 <- rast("mng8.tiff") #NIR

mng21 <- c(mng5, mng6, mng7, mng8) #creazione secondo stack con 4 layer del 2021
#funzione par, unire le immagini


