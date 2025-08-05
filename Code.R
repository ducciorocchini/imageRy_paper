library(imageRy)
library(terra)
library(ggplot2)
library(patchwork) # for coupling ggplot2 graphs
library(viridis)

# Importing Mato Grosso data
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# DVI
dvi1992 <- im.dvi(mato1992, 1, 2)
dvi2006 <- im.dvi(mato2006, 1, 2)

par(mfrow=c(1,2))
plot(dvi1992, col=inferno(256), axes=F)
plot(dvi2006, col=inferno(256), axes=F)

# Classification
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

mato1992 <- flip(mato1992)
mato2006 <- flip(mato2006)

set.seed(50)
mato1992c <- im.classify(mato1992, num_clusters=2)
mato2006c <- im.classify(mato2006, num_clusters=2)

classes_names <- c("Human", "Forest")

par(mfrow=c(1,2))
plot(mato1992c, type="classes", levels=classes_names, axes=F)
plot(mato2006c, type="classes", levels=classes_names, axes=F)

## Calculating proportions
prop1992 <- freq(mato1992c)*100/ncell(mato1992c)
prop2006 <- freq(mato2006c)*100/ncell(mato2006c)

## Creating a final dataframe (use the count column from prop1992 and prop2006)
# Columns:
class <- c("Human","Forest")
p1992 <- c(17,83)
p2006 <- c(45,55)
tabout <- data.frame(class, p1992, p2006)

## Final plot (classification)
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

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

#----

# Band 2 figure from Sentinel-2 of the Tofane area

pdf(file="~/Desktop/output.pdf", width=9, height=4) # default is 7
im.multiframe(1,3)
plot(b2)
plot(b2, col=clcyan)
plot(b2, col=inferno(100))
dev.off()

