# For every figure in the paper the header is defined by: #####
# e.g.: ##### Single band plotting #####
# We avoid using Figure 1, Figure 2, etc. in case the paper is changing in time

##### PACKAGES #####

library(imageRy)   # Core package for raster image processing (importing, plotting, indices, classification, PCA, kernels)
library(terra)     # Handling raster data structures and extracting pixel values / frequency tables
library(ggplot2)   # Advanced plotting (scatterplots, histograms, faceting, themes)
library(patchwork) # Combining multiple ggplot2 plots into composite figures
library(viridis)   # Perceptually uniform color palettes (inferno, viridis, cividis)
library(dplyr)     # Data manipulation (mutate, transmute, filter, bind_rows, piping)
library(GGally)    # Scatterplot matrices (ggpairs) for multivariate band comparisons

##### SINGLE BAND PLOTTING #####
sentb2 <- im.import("sentinel.dolomites.b2.tif")

cl_cyanblue <- colorRampPalette(c(
  "navy",
  "royalblue4",
  "royalblue2",
  "deepskyblue3",
  "turquoise3",
  "mediumaquamarine",
  "palegreen"
))(100)

im.multiframe(1, 3)

# --- Panel A ---
plot(sentb2)
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B ---
plot(sentb2, col = cl_cyanblue)
mtext("B)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel C ---
plot(sentb2, col = inferno(100))
mtext("C)", side = 3, line = 1, adj = 0, font = 2)

##### RGB SPACE PLOTTING #####

# Sentinel 4 bands
sent <- im.import("sentinel.dolomites")

par(mar = c(3.5, 3, 2.5, 1))
im.multiframe(2,2)

# --- Panel A: RGB visible ---
im.plotRGB(sent, r = 3, g = 2, b = 1)
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B: NIR on red channel ---
im.plotRGB(sent, r = 4, g = 3, b = 2)
mtext("B)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel C: NIR on green channel ---
im.plotRGB(sent, r = 3, g = 4, b = 2)
mtext("C)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel D: NIR on blue channel ---
im.plotRGB(sent, r = 3, g = 2, b = 4)
mtext("D)", side = 3, line = 1, adj = 0, font = 2)

##### DVI with Brazil data #####
brazil <- im.import("S2_AllBands_tropical.tif")
dviind <- im.dvi(brazil, 8, 4)
ndviind <- im.ndvi(brazil, 8, 4)

im.multiframe(1, 3)  # equivalent to par(mfrow = c(1,3))

# --- Panel A ---
im.plotRGB(brazil, 4, 8, 2)
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B ---
plot(dviind, col = inferno(100))
mtext("B)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel C ---
plot(ndviind, col = inferno(100))
mtext("C)", side = 3, line = 1, adj = 0, font = 2)

##### CLASSIFICATION #####

falz <- im.import("S2_AllBands_temperate_passo_falzarego.tif")

# build a 4-band stack (B2, B3, B4, B8)
falz4 <- c(falz[[2]], falz[[3]], falz[[4]], falz[[8]])
names(falz4) <- c("B2","B3","B4","B8")

# visualize (RGB)
im.plotRGB(falz4, 2, 4, 3)

# unsupervised classification (k-means-like clustering)
set.seed(42)
falzc <- im.classify(falz4, num_clusters=3)

# plot the classification result
plot(falzc)
# show RGB and classes side-by-side

im.multiframe(1, 2)

# --- Panel A ---
im.plotRGB(falz4, 2, 4, 3)
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B ---
# define the colors you want (one per class)
cols <- c("#371259", "#21908C", "#7FE65C")

plot(falzc,
     col = cols,
     legend = TRUE)

mtext("B)", side = 3, line = 1, adj = 0, font = 2)

##### SCATTERPLOT MATRIX OF CLASSES #####

# Give bands friendly names (optional but helps a lot)
names(falz4) <- c("B2","B3","B4","B8")

# Optional: drop NA pixels consistently across bands
# (classify output might already match, but this is safe)
# We'll sample to keep it fast and readable.
set.seed(42)
n <- 50000  # increase/decrease as you like

# sample pixel indices from non-NA area
v_mask <- !is.na(values(falzc))
idx <- which(v_mask)

idx_s <- sample(idx, size = min(n, length(idx)))

# extract values
X  <- values(falz)[idx_s, , drop = FALSE]
cl <- values(falzc)[idx_s, 1]

dat <- as.data.frame(X) %>%
  mutate(cluster = factor(cl))

# Simple plot
# ggplot(dat, aes(B4, B8, color = cluster)) +
  geom_point(alpha = 0.35, size = 0.6) +
  theme_minimal()

# All band-vs-band scatters in one figure

GGally::ggpairs(
  dat,
  columns = c("B2","B3","B4","B8"),
  aes(color = cluster, fill = cluster, alpha = 0.35),
  diag = list(
    continuous = wrap(
      "densityDiag",
      alpha = 0.5
    )
  )
) +
  scale_color_viridis_d(
    option = "D",
    end = 0.85,
    name = "Cluster"
  ) +
  scale_fill_viridis_d(
    option = "D",
    end = 0.85,
    guide = "none"
  ) +
  theme_minimal()

# Divided (optional)
ggplot(dat, aes(B4, B8)) +
  geom_point(size = 1.8, colour = "black") +
  facet_wrap(~ cluster) +
  theme_gray(base_size = 12) +
  labs(x = "B4", y = "B8")

# Megagraph (optional)

bands <- c("B2", "B3", "B4", "B8")

# all pairwise bands (no repetition)
band_pairs <- combn(bands, 2, simplify = FALSE)

plot_df <- bind_rows(lapply(band_pairs, function(p) {
  dat %>%
    transmute(
      x = .data[[p[1]]],
      y = .data[[p[2]]],
      pair = paste(p[1], "vs", p[2]),
      cluster
    )
}))

ggplot(plot_df, aes(x, y)) +
  geom_point(size = 1.2, colour = "black", alpha = 0.6) +
  facet_grid(cluster ~ pair, scales = "fixed") +
  theme_gray(base_size = 11) +
  labs(
    x = NULL,
    y = NULL
  )

###### HISTOGRAMS ON CLASSIFIED MAP #####

# frequency table (counts)
fr <- terra::freq(falzc)
  
percs <- as.data.frame(fr) %>%
  filter(!is.na(value)) %>%
  transmute(
    cluster = factor(value),
    n = count,
    perc = 100 * n / sum(n)
  )

percs

ggplot(percs, aes(cluster, perc, fill = cluster)) +
  geom_col(colour = "black", width = 0.65) +
  geom_text(aes(label = sprintf("%.1f%%", perc)),
            vjust = -0.6, size = 4) +
  scale_fill_viridis_d(option = "D", end = 0.85, name = "Cluster") +
  scale_y_continuous(limits = c(0, max(percs$perc) * 1.15), expand = c(0, 0)) +
  theme_gray(base_size = 12) +
  labs(x = "Cluster", y = "Area (%)", title = "Class proportions")

###### VARIABILITY MEASUREMENT #####
sentsd <- im.kernel(sent[[4]], mw=5, stat="sd")

im.plotRGB(sent, 3, 4, 2)
plot(sentsd, col=viridis(255))

###### MULTIVARIATE ANALYSIS #####
sentpca <- im.pca(sent)
sentpca
plot(sentpca)

sentpcasd <- im.kernel(sentpca[[1]], mw=5, stat="sd")

im.multiframe(1, 2)

# --- Panel A ---
plot(sentsd, col = viridis(255))
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B ---
plot(sentpcasd, col = cividis(100))
mtext("B)", side = 3, line = 1, adj = 0, font = 2)

