library(ggplot2)
library(grid)

# simulate correlated bands
set.seed(42)
n <- 1000
band1 <- rnorm(n)
band2 <- 0.7 * band1 + rnorm(n, sd = 0.5)

df <- data.frame(band1, band2)

# PCA
pca <- prcomp(df, scale. = TRUE)
eig <- pca$rotation

# flip orientation (rotate in opposite sense)
eig[,1] <- -eig[,1]
eig[,2] <- -eig[,2]

# extend lines
t <- seq(-5, 5, length.out = 100)

pc1_line <- data.frame(
  x = t * eig[1,1],
  y = t * eig[2,1]
)

pc2_line <- data.frame(
  x = t * eig[1,2],
  y = t * eig[2,2]
)

# endpoints for arrows
pc1_end <- eig[,1] * 5
pc2_end <- eig[,2] * 5

# plot
ggplot(df, aes(band1, band2)) +
  geom_point(alpha = 0.4, color = "darkolivegreen3") +

  # PC lines
  geom_path(data = pc1_line, aes(x, y),
            color = "darkblue", linewidth = 0.8) +
  
  geom_path(data = pc2_line, aes(x, y),
            color = "lightblue", linewidth = 0.8) +

  # labels ABOVE arrow tips
  annotate("text",
           x = pc1_end[1],
           y = pc1_end[2],
           label = "PC1",
           color = "darkblue",
           vjust = -1) +
  
  annotate("text",
           x = pc2_end[1],
           y = pc2_end[2],
           label = "PC2",
           color = "lightblue",
           vjust = -1) +

  # arrows LAST → always on top
  geom_segment(aes(x = 0, y = 0,
                   xend = pc1_end[1],
                   yend = pc1_end[2]),
               color = "darkblue",
               linewidth = 0,
               arrow = arrow(length = unit(0.4, "cm"))) +
  
  geom_segment(aes(x = 0, y = 0,
                   xend = pc2_end[1],
                   yend = pc2_end[2]),
               color = "lightblue",
               linewidth = 0,
               arrow = arrow(length = unit(0.4, "cm"))) +


  theme_minimal(base_size = 14) +
  labs(
    x = "Band 1",
    y = "Band 2",
    title = "Principal Component Axes in Spectral Feature Space"
  ) + 

  theme(
  axis.text = element_blank(),
  axis.ticks = element_blank()
  )
