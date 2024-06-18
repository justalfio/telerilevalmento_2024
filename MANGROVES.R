library(terra) #per la funzione rast
library(ggplot2) #per costruire grafici
library(imageRy) #per la funzione im.classify(), im.pca() e im.plotRGB()
library(patchwork) #per unire i grafici

#cambio directory
setwd("C:/Users/Utente/Desktop/TELERILEVAMENTO/mangroves 1")

# ad ogni banda noi assegneremo un'immagineA
mng1 <- rast("mng3.tiff") #blue
mng2 <- rast("mng2.tiff") #green 
mng3 <- rast("mng1.tiff") #red
mng4 <- rast("mng4.tiff") #NIR

mng16 <- c(mng1, mng2, mng3, mng4) 
#creo il primo stack dei 4 layer del 2016
im.plotRGB(mng16, 1, 2, 4) 
# inserisco la banda del NIR al posto della banda del blu così da ottenere in blu ciò 
# che è la vegetazione delle mangrovie e in giallo ottengo ciò che riflette poco, esaltando dunque la variazione tra i due anni
# in giallo che è il colore che più colpisce la retina.


#assegno ad ogni immagine una banda per il 2021
mng5 <- rast("mng7.tiff") #blue
mng6 <- rast("mng6.tiff") #green
mng7 <- rast("mng5.tiff") #red
mng8 <- rast("mng8.tiff") #NIR

mng21 <- c(mng5, mng6, mng7, mng8) #creazione secondo stack con i 4 layer del 2021

# funzione par, unire le immagini
par(mfrow=c(1,2)) #creazione di un par per il confronto delle due immagini. 

# ri-plottiamo i due stack di layer in modo da poter osservare la differenza ad occhio nudo degli effetti antropici 
# sulle mangrovie, mettendo il NIR sul verde.
im.plotRGB(mng16, 2,4,3)
im.plotRGB(mng21, 2,4,3)

# Scegliamo una palette di colori 
# Scelgo (green4, seagreen1, sandybrown)
leaf <- colorRampPalette(c("sandybrown","green4", "seagreen1")) (100)

# calcolo del DVI (difference vegetation index); utilizzo l'uguale perché è una operazione matematica
# si prende la banda del NIR e si esegue una sottrazione di pixel con la banda del Rosso
# se il risultato della sottrazione sarà alto allora quel pixel comprende una zona di vegetazione
# L'intervallo di valori dell'NDVI è compreso tra -1 e 1. I valori negativi dell'NDVI (valori che si avvicinano a -1) 
# corrispondono all'acqua. I valori vicini allo zero (-0.1 a 0.1) generalmente corrispondono ad aree sterili di roccia
# sabbia o neve. I valori positivi bassi rappresentano arbusti e praterie (circa 0.2 a 0.4), mentre i valori alti indicano 
# foreste pluviali temperate e tropicali (valori che si avvicinano a 1).

# la scelta di banda 3 (banda del rosso per sentinel 2) e banda 4 (NIR per sentinel 2) è dovuta al fatto sia che NDVI si calcola
# sottraendo il NIR a red, sia che eliminando la banda del rosso permette di differenziare meglio ciò che non è vegetazione 
# (urbanizzazione, acqua) e vegetazione (più chiara, annuale, più scura arborea.

dvimng16 = mng16[[4]] - mng16[[3]] 
dvimng21 = mng21[[4]] - mng21[[3]]

#dopo aver calcolato dvi, creaiamo un par inserendo i due plot con la colorRampPalette scelta per vedere le differenze
par(mfrow=c(1,2))
plot(dvimng16, col=leaf)
plot(dvimng21, col=leaf)

# per la visualizzazione del DVI scelgo anche la colorRampPalette "viridis", adatta alla visualizzazione della variazione 
# per i daltonici
# (richiamo viridis)
library(viridis)
viridisc <- colorRampPalette(viridis(7))(100)
plot(dvimng21, col=viridisc)
plot(dvimng16, col=viridisc)

#si osserva così con il blu scuro la componente non vegetazionale, giallo annuale e in turchese l'arborea


# Calcoliamo la Normalized Difference Vegetation Index NDVI che varia da 1 a -1
# La usiamo perché è un indice normalizzato che ci fornsice valori standardizzati che possono
# essere di più facile interpretazione e possono essere usati per confrontare immagini
# di dimensioni diverse 

# NDVI= (NIR-red)/(NIR+red)
ndvi2016= dvimng16/mng16[[3]]+mng16[[4]]
ndvi2021= dvimng21/mng21[[3]]+mng21[[4]]

# dopodiché plotto anche ora le due NDVI, dopo aver visionato i dati, e le confronto a livello visivo
plot(ndvi2016, col=viridisc)
plot(ndvi2021, col=viridisc)

# passo alla classificazione
# Classifichiamo con 2 cluster le immagini

# 2016
class16 <- im.classify(ndvi2016, num_clusters=2)
class.names <- c("non vegetation", "mangroves")
#Plottiamo dando un titolo all'immagine e un nome alle classi
plot(class16, main= "Classificazione 2016", type="classes", levels= class.names)

# 2021
class21 <- im.classify(ndvi2021, num_clusters=2)
class.names <- c("non vegetation", "mangroves")
plot(class21, main= "Classificazione 2021", type="classes", levels=class.names)


# Calcoliamo la frequenza dei pixel presenti in una classe
# e quella dei pixel presenti nell'altra
# 2016
freq16 <- freq(class16)
freq16
# non vegetation= 593608; # mangroves= 968892

#Calcoliamo il totale dei pixel
tot16 <- ncell (class16)
tot16
# 1562500 
#Proporzione
prop16 = freq16/tot16
prop16
# layer    value     count
#1 6.4e-07 6.40e-07 0.3799091
#2 6.4e-07 1.28e-06 0.6200909

perc16 = prop16*100
perc16
#PERCENTUALI
# layer 1 (non vegetation)=37,99%
# layer 2 (mangroves)) 62,01%

# 2021
freq21 <- freq(class21)
freq21
# "non vegetation"= 612849; "mangroves"= 949651

# Calcoliamo il totale dei pixel
tot21 <- ncell (class21)
tot21 # lo stesso valore ottenuto precedentemente
# Proporzione
prop21 = freq21/tot21
prop21
#    layer    value     count
# 1 6.4e-07 6.40e-07 0.3922234
# 2 6.4e-07 1.28e-06 0.6077766

perc21 = prop21*100
perc21
# PERCENTUALI
# layer 1(non vegetation)= 39,22%
# layer 2(mangroves)= 60,78%

# costruisco il dataset e creo i grafici
# Per prima cosa andiamo a creare una tabella per confrontare 
# la variazione delle frequenze
class <- c("non vegetation", "mangroves") # la prima colonna rappresentata dai nomi presenti nella classificazione
y2016 <- c(37.9, 62.1) # seconda colonna con percentuali 2016
y2021 <- c(39.2, 60.8) # terza colonna con percentuali 2021

tabout <- data.frame(class, y2016, y2021) # creiamo il data set con la funzione data.frame per visualizzare le 4 percentuali
tabout
#          class y2016 y2021
#1 non vegetation  37.9  39.2
#2      mangroves  62.1  60.8

# Adesso creiamo i grafici utilizzando ggplot, aes sta per aesthetic, con questo creiamo uno scheletro
# 2016
# stat= identity indica il valore che abbiamo, fill=colore indica il colore che intendiamo usare

ggplot(tabout, aes(x=class, y= y2016, color=class)) +  geom_bar(stat="identity", aes(fill= class), width= 0.7)+
ylim(c(0,100)) +
ggtitle("Mongla's Mangroves 2016") + xlab("Classi") + ylab("Percentuale di copertura")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 

# 2021
ggplot(tabout, aes(x=class, y= y2021, color=class)) +  geom_bar(stat="identity", aes(fill= class), width= 0.7)+
ylim(c(0,100)) +
ggtitle("Mongla's Mangroves 2021") + xlab("Classi") + ylab("Percentuale di copertura")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 

#Visualizziamo i due grafici insieme con patchwork
p1 <- ggplot(tabout, aes(x=class, y= y2016, color=class)) +  geom_bar(stat="identity", aes(fill= class), width= 0.7)+
ylim(c(0,100)) +
ggtitle("Mongla's Mangroves 2016") + xlab("Classi") + ylab("Percentuale di copertura")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 
p2 <- ggplot(tabout, aes(x=class, y= y2021, color=class)) +  geom_bar(stat="identity", aes(fill= class), width= 0.7)+
ylim(c(0,100)) +
ggtitle("Mongla's Mangroves 2021") + xlab("Classi") + ylab("Percentuale di copertura")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 
p1 + p2

dev.off

# adesso digito la funzione pairs per i due stack di immagini in modo da osservare la correlazione tra bande:
pairs(mng16)
pairs(mng21)

# dal pairs vedo che la correlazione è più o meno simile tra le tre bande e va ad abbassarsi nel NIR

# faccio la PCA per entrambi gli anni, con im.pca calcoliamo i valori delle componenti principali delle 4 bande. im.pca nella visualizzazione delle immagini 
# da sempre le prime 3 del plot, nel nostro caso PC4 la esclude.

pcamng16 <- im.pca(mng16)
pcamng21 <- im.pca(mng21)
# Calcoliamo le percentuali delle componenti principali
# 2016
pcamng16 <- im.pca(mng16)
tot <-sum( 5542.8700, 1295.9294,  226.6068,  125.0946)
# tot pc1= 77,1%
5542.8700*100/tot
# tot pc2= 18%
1295.9294é100/tot
# tot pc3= 3,1%
226.6068*100/tot
#tot pc4= 1,7%
125.0946*100/tot

#2017
pcamng21 <- im.pca(mng21)
tot <- sum(6132.5105, 1646.7272,  200.3031,  115.1301)

# tot pc1= 75,8%
6132.5105*100/tot
# tot pc2= 20,3%
1646.7272*100/tot
# tot pc3= 2,5%
200.3031*100/tot
# tot pc4= 1,4%
115.1301*100/tot


# pc1 per definizione è quella più rappresentativa, dunque scelgo quella per la funzione focal.
# FUNZIONE FOCAL = Tira fuori delle statistiche, dei valori focali da una variabile, quindi media, 
# varianza, deviazione standard, ecc...

# a questo punto, funzione focal per il calcolo della standard deviation
sdmng16 <- focal(pcamng16[[1]], matrix(1/9, 3,3), fun=sd)
sdmng21 <- focal(pcamng21[[1]], matrix(1/9, 3,3), fun=sd)

#plottiamo le immagini con viridis per non disturbare i daltonici con i colori, creando uno stack
sdstack <-c(sdmng16, sdmng21)
plot(sdstack, col=viridisc)


# In questo caso, il confronto tra le immagini nello stack ci mostra che un minimo di variabilità della zona considerata c'è,
# di circa il 2% come mostrato dalle analisi delle componenti. Dunque non un valore molto elevato ma che ci permette comunque di
# poter apprezzare la riduzione delle mangrovie e l'espansione dell'intervento antropico proveniente da Mongla.



