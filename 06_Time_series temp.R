# progetto di ricerca, con codice e presentazione, bisogna importare dei dati dall'esterno. Lezione successiva su ESA Copernicus.
# Second method to quantify changes in time
# the first method was based on classification
# richiamare terra e imageRy come sempre, funzione library(terra), lirbary(imageRy)
# Sentinel-2 risoluzione 10m, solitamente quello usato
# lista (list()) dei dati: im.list()
# importing data;
im.import("") prima quello di GENNAIO e poi MARZO
EN01<- im.import("EN_01")
EN13<- im.import("EN_13")
°facciamo un par
par(mfrow=c(1,2))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)
# abbiamo importato immagini RGB con 3 bande
difEN = EN01[[1]] - EN13[[1]], si sono presi i pixel del primo livello, visto NO2 del primo livello e si sottraggono i pixel del 2013
cl <- colorRampPalette(c("red","white","blue")) (100)
plot(difEN, col=cl)
# range iniziale 8 bit da (0 a 255), à
#applicheremo le stesse regole per lo scioglimento dei ghiacci.
# geom line fa linee, geom bar fa istogrammi
# ice melt in Greenland
g2000<- im.import("greenland.2000.tif")
clg2000 <- colorRampPalette(c("black","red","white","blue")) (100)
plot(g2000, col=clg2000);
# mappa di temperature
# importare altre immagini groenlandia
g2005<-im.import("greenland.2005.tif")
g2010<-im.import("greenland.2010.tif")
g2015<-im.import("greenland.2015.tif")

par(mfrow=c(1,2)
plot(g2000, col=clg2000)
plot(g2005, col=clg2000)

    #stack
greenland<-c(g2000, g2005, g2010, g2015)
    plot(greenland, col=clg2000)

difg = greenland[[1]] - greenland [[4]]
    plot(difg, col=cl)
    clgreen <- colorRampPalette(c("blue","white","red")) (100)
    # poiché sottraiamo un negativo ad un positivo, rispetto a prima abbiamo invertito i colori per evidenziare ocl rosso l'aumento della T.
# im.plotRGB(greenland, 1, 2, 3) 
    # assegnamo ad ogni immagine una banda per creare una sovrapposizione, utilizziamo lo stack
  im.plotRGB(greenland, r=1, g=2, b=3) # g2000 on red, g2005 on green, g2015 on blue
    parte rossa pè ,a zona a T più altra nel 2000, la verde la più alta nel 2005 e la blu è la T più alta nel 2015.
# per sottrarre bisogna avere immagini uguali.
    
    
