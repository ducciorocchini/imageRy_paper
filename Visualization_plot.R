# Load required packages
# imageRy: core package for remote sensing workflows used in this script
library(imageRy)

# terra: handles raster data (SpatRaster objects, spatial operations)
library(terra)

# patchwork: used to combine multiple ggplot objects into a single layout
library(patchwork)

# ggplot2: provides the plotting framework used by imageRy visualization functions
library(ggplot2)

# viridis: color palettes (perceptually uniform and colorblind-friendly)
library(viridis)

# List available example images
im.list()

# Import Sentinel Dolomites raster image
sent <- im.import("sentinel.dolomites")

# Classify data
class <- im.classify(sent, num_clusters = 3, do_plot = F)

# Save RGB composite and classified image plot
p1 <- im.ggplotRGB(sent, 2, 4, 3)

# Create ridgeline plot with mako palette
p2 <- im.ridgeline(sent, scale = 2, palette = "mako")

# Define custom colors
class_cols <- viridis::viridis(3, end = 0.5)

# Create barplot of class percentages
p3 <- im.barplot(
  class,
  perc = TRUE,
  counts = TRUE,
  rescale = TRUE,
  custom_colors = class_cols
)

# Create boxplot of band 4 values grouped by classes
p4 <- im.boxplot(
  sent, class, layer = 4,
  density = TRUE,
  median_labels = TRUE,
  legend = FALSE,
  limits = c(0.01, 0.99), 
  custom_colors = viridis::viridis(4, end = 0.5)
)

# Combine final plots
p1 + p2 + p3 + p4
