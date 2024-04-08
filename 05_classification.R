LEZIONE 08/04/24
# far capire al sistema mediante dei machine learning, spiegando cosa sono i diversi elementi. 
# quantifying land cover change
@ installpackages ("ggplot2")
library(terra)
library(imageRy)
library(ggplot2)
im.list(https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6)
        im.list("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
        im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# importing images
sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# classifying images 
sun<-im.classify(sun, num_cluster=3)
#importing matogrosso
im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import( "matogrosso_ast_2006209_lrg.jpg"  )


#classifying images
m1992c<-im.classify(m1992, num_clusters=2)
# m19992 classe 1 = human-based
# classe 2= forest


#frequencies
f1992<-freq(

        #proportions pixels
        tot1992<-ncell(m1992)
        f1992 <- freq(m1992c)
f1992
tot1992 <- ncell(m1992c)
# percentage
p1992 <- f1992 * 100 / tot1992 
p1992
# forest: 83%; human: 17%

        #2006 percentuale: 55%human 45% forest
        #CREARE UN NOSTRO DATASET, distribuendo i nostri dati in una tabella, data.frame funzione per creare da zero
#building final table
        #3 colonne, prima col. classe (Forest, e poi human, nelle tabelle le lettere(parole sempre tra virgolette, numeri mai
        2 colonna percentuale 1992
        3 colonna percentuale 2006

        # let's build data frame
        class<-c("forest, human")
        p1992<-c(83,17)
        p2006<-c(45,55)
        
        finaltable<-data.frame(class,p1992,p2006)
        finaltable

# plotting output
ggplot(tabout, aes(x=class, y=y1992, color=class)) aes sono la X e la Y

#add function 
geom_bar(stat="identity",fill="white")
        stat= identity indica il valore che abbiamo, fill=colore indica il colore che intendiamo usare
        gli istobgrammi rappresentanto una statistica basandocis sul dataset, ma in questo caso usiamo identity perché stiamo rappresentando un dato

# launch patchwork ----> library(patchwork)
        #patchwork
        p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
        p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
        p1+p2
