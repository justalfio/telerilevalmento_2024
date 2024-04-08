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


#classyfing m2006
im.classify(m2006, num_clusters=2)
# also in this case: classe 1=human based
# classe 2: forest

# calculating frequencies
