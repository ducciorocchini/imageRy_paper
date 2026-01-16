library(imageRy)
library(terra)
library(ggplot2)
library(patchwork) # for coupling ggplot2 graphs
library(viridis)

# Single band plotting
sentb2 <- im.import("sentinel.dolomites.b2.tif")
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(100)}117

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

# Sentinel 4 bands
sent <- im.import("sentinel.dolomites")


# DVI with Brazil data
brazil <- im.import("S2_AllBands_tropical.tif")
dviind <- im.dvi(brazil, 8, 4)
ndviind <- im.ndvi(brazil, 8, 4)

library(viridis)

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


# Classification

fal <- im.import("S2_AllBands_temperate_passo_falzarego.tif")

fal <- c(fal[[2]], fal[[3]], fal[[4]], fal[[8]])
im.plotRGB(fal, 2, 4, 3)

set.seed(42)
falc <- im.classify(fal, num_clusters=3)
plot(falc)

# show RGB and classes side-by-side
im.multiframe(1, 2)

# --- Panel A ---
im.plotRGB(falz4, 2, 4, 3)
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B ---
plot(falzc)
mtext("B)", side = 3, line = 1, adj = 0, font = 2)

library(terra)
library(dplyr)
library(ggplot2)

# Give bands friendly names (optional but helps a lot)
names(fal) <- c("B2","B3","B4","B8")

# Optional: drop NA pixels consistently across bands
# (classify output might already match, but this is safe)
# We'll sample to keep it fast and readable.
set.seed(42)
n <- 50000  # increase/decrease as you like

# sample pixel indices from non-NA area
v_mask <- !is.na(values(falc))
idx <- which(v_mask)

idx_s <- sample(idx, size = min(n, length(idx)))

# extract values
X  <- values(fal)[idx_s, , drop = FALSE]
cl <- values(falc)[idx_s, 1]

dat <- as.data.frame(X) %>%
  mutate(cluster = factor(cl))

# Simple plot
# ggplot(dat, aes(B4, B8, color = cluster)) +
  geom_point(alpha = 0.35, size = 0.6) +
  theme_minimal()

# All band-vs-band scatters in one figure
# install.packages("GGally") if needed
library(GGally)
library(viridis)

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

# Divided
ggplot(dat, aes(B4, B8)) +
  geom_point(size = 1.8, colour = "black") +
  facet_wrap(~ cluster) +
  theme_gray(base_size = 12) +
  labs(x = "B4", y = "B8")

# Megagraph
library(dplyr)
library(tidyr)
library(ggplot2)

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

# Histograms
library(terra)
library(dplyr)

# frequency table (counts)
fr <- terra::freq(falc)

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

# Variability measurement
sentsd <- focal(sent[[4]], w=5, fun=sd)

im.plotRGB(sent, 3, 4, 2)
plot(sentsd, col=viridis(255))

# Multivariate analysis
sentpca <- im.pca(sent)
sentpca
plot(sentpca)

sentpcasd <- focal(sentpca[[1]], w=5, fun=sd)

im.multiframe(1, 2)

# --- Panel A ---
plot(sentsd, col = viridis(255))
mtext("A)", side = 3, line = 1, adj = 0, font = 2)

# --- Panel B ---
plot(sentpcasd, col = cividis(100))
mtext("B)", side = 3, line = 1, adj = 0, font = 2)

#----
