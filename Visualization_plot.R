# Load imageRy package
library(imageRy)
library(terra)
library(pacthwork)
library(ggplot2)
library(viridis)

# List available example images
im.list()

# Import Sentinel Dolomites raster image
sent <- im.import("sentinel.dolomites")

# Classify data
class <- im.classify(sent, num_cluster = 3)

# Save RGB composite and classified image plot
p1 <- im.ggplotRGB(sent, 2, 4, 3)

# Define custom colors
class_cols <- viridis::viridis(3, end = 0.5)

# Create barplot of class percentages
p4 <- im.barplot(
  class,
  perc = TRUE,
  counts = TRUE,
  rescale = TRUE,
  custom_colors = class_cols
)

# Create boxplot of band 4 values grouped by classes
p3 <- im.boxplot(
  sent, class, layer = 4,
  density = TRUE,
  median_labels = TRUE,
  legend = FALSE,
  limits = c(0.01, 0.99), 
  custom_colors = viridis::viridis(4, end = 0.5)
)

# Create ridgeline plot with mako palette
p6 <- im.ridgeline(sent, scale = 2, palette = "mako")

# Combine final plots
p1 + p6 + p4 + p3
