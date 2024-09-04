library(imageRy)
library(terra)
library(patchwork) # for coupling ggplot2 graphs
library(viridis)

# Variability measurement
im.list()
sent <- im.import("sentinel.png")
sent <- c(sent[[1]], sent[[2]], sent[[3]])
sentsd <- focal(sent[[1]], matrix(1/25, 5, 5), fun=sd)

im.plotRGB(sent, 1, 2, 3)
plot(sentsd, col=viridis(255))

# Multivariate analysis
sentpca <- im.pca(sent)
sentpca
plot(sentpca)

sentpcasd <- focal(sentpca[[1]], matrix(1/25, 5, 5), fun=sd)

par(mfrow=c(1,3))
plotRGB(sent,1,2,3)
plot(sentsd, col=viridis(255), main="standard deviation on band 1")
plot(sentpcasd, col=magma(100), main="standard deviation on PC1")

# Classification
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

mato1992c <- im.classify(mato1992, num_clusters=2)
mato2006c <- im.classify(mato2006, num_clusters=2)

classes_names <- c("Forest", "Human")

par(mfrow=c(1,2))
plot(mato1992c, type="classes", levels=classes_names)
plot(mato2006c, type="classes", levels=classes_names)

## Final plot (classification)
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
