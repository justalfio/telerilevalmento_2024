library(terra) #per la funzione rast
library(ggplot2) #per costruire grafici
library(imageRy) #per la funzione im.classify(), im.pca() e im.plotRGB()
library(patchwork) #per unire i grafici

#cambio directory
setwd("C:/Users/Utente/Desktop/TELERILEVAMENTO/mangroves 1")

# ad ogni banda noi assegneremo un'immagine
mng1 <- rast("mng1.tiff") #blue
mng2 <- rast("mng2.tiff") #green 
mng3 <- rast("mng3.tiff") #red
mng4 <- rast("mng4.tiff") #NIR

mng16 <- c(mng1, mng2, mng3, mng4) #creo il primo stack dei 4 layer del 2016
#inserisco la banda del NIR al posto della banda del Verde così da ottenere in verde ciò che è la foresta pluviale
im.plotRGB(mng16, 2, 4, 3) #inserisco la banda del NIR al posto della banda del Verde così da ottenere in verde ciò che è la vegetazione delle mangrovie


#assegno ad ogni immagine una banda per il 2021
mng5 <- rast("mng5.tiff") #blue
mng6 <- rast("mng6.tiff") #green
mng7 <- rast("mng7.tiff") #red
mng8 <- rast("mng8.tiff") #NIR

mng21 <- c(mng5, mng6, mng7, mng8) #creazione secondo stack con i 4 layer del 2021

# funzione par, unire le immagini
par(mfrow=c(1,2)) #creazione di un par per il confronto delle due immagini. 

# ri-plottiamo i due stack di layer in modo da poter osservare la differenza ad occhio nudo degli effetti antropici sulle mangrovie
im.plotRGB(mng16, 2,4,3)
im.plotRGB(mng21, 2,4,3)

# Scegliamo una palette di colori 
# Scelgo (green4, seagreen1, sandybrown)
leaf <- colorRampPalette(c("green4", "seagreen1", "sandybrown",)) (100)

# calcolo del DVI (difference vegetation index); utilizzo l'uguale perché è una operazione matematica
# si prende la banda del NIR e si esegue una sottrazione di pixel con la banda del Rosso
# se il risultato della sottrazione sarà alto allora quel pixel comprende una zona di vegetazione
# L'intervallo di valori dell'NDVI è compreso tra -1 e 1. I valori negativi dell'NDVI (valori che si avvicinano a -1) 
# corrispondono all'acqua. I valori vicini allo zero (-0.1 a 0.1) generalmente corrispondono ad aree sterili di roccia
# sabbia o neve. I valori positivi bassi rappresentano arbusti e praterie (circa 0.2 a 0.4), mentre i valori alti indicano 
# foreste pluviali temperate e tropicali (valori che si avvicinano a 1).

# la scelta di banda 1 (banda del blu per sentinel 2) e banda 4 (NIR per sentinel 2) è dovuta al fatto che eliminando la banda del blu
# permette di differenziare meglio ciò che non è vegetazione (urbanizzazione, acqua) e vegetazione (più chiara (annuale) più

dvimng16 = mng16[[4]] - mng16[[1]] 
dvimng21 = mng21[[4]] - mng21[[1]]

#dopo aver calcolato dvi, creaiamo un par inserendo i due plot con la colorRampPalette scelta per vedere le differenze
par(mfrow=c(1,2))
plot(dvimng16, col=leaf)
plot(dvimng21, col=leaf)

#Calcoliamo la Normalized Difference Vegetation Index NDVI che varia da 1 a -1
#La usiamo perché è un indice normalizzato che ci fornsice valori standardizzati che possono
#essere di più facile interpretazione e possono essere usati per confrontare immagini
#di dimensioni diverse 

#NDVI= (NIR-red)/(NIR+red)
ndvi2016= dvimng16/mng16[[1]]+mng16[[4]]
ndvi2021= dvimng21/mng21[[1]]+mng21[[4]]

# per la visualizzazione dell'NDVI scelgo la colorRampPalette "viridis", adatta alla visualizzazione della variazione per i daltonici
# (richiamo viridis)
library(viridis)
