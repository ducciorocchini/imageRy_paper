# Classification: final plot
library(patchwork)
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

# Variability measurement

library(viridis)

im.list()
sent <- im.import("sentinel.png")
sent <- c(sent[[1]], sent[[2]], sent[[3]])
sentsd <- focal(sent, matrix(1/25, 5, 5), fun=sd)

im.plotRGB(sent, 1, 2, 3)
plot(sentsd, col=viridis(255))

# Multivariate analysis
sentpca <- im.pca(sent)
sentpca
plot(sentpca)

sentpcasd <- focal(sentpca, matrix(1/25, 5, 5), fun=sd)

plot(sentpcasd, col=magma(100))
