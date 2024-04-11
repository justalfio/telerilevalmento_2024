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
cl <- colorRampPalette("red","white","blue")) (100)
plot(difEN, col=cl)
# range iniziale 8 bit da (0 a 255), à
#applicheremo le stesse regole per lo scioglimento dei ghiacci.
