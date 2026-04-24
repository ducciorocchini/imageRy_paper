# Load imageRy package
library(imageRy)

# List available example images
im.list()

# Import Sentinel Dolomites raster image
sent <- im.import("sentinel.dolomites")

# Create a ridgeline plot of the Sentinel image
sent <- im.ridgeline(sent, scale = 1)

# Re-import Sentinel image because sent was overwritten by the ridgeline plot
sent <- im.import("sentinel.dolomites")

# Import Sentinel image again as a separate object
ridge <- im.import("sentinel.dolomites")

# Re-import Sentinel image
sent <- im.import("sentinel.dolomites")

# Create ridgeline plots with different vertical scaling
ridge <- im.ridgeline(sent, scale = 1)
ridge <- im.ridgeline(sent, scale = 2)
ridge <- im.ridgeline(sent, scale = 4)
ridge <- im.ridgeline(sent, scale = 2)

# Classify the Sentinel image into 4 and then 3 clusters
class <- im.classify(sent, num_cluster = 4)
class <- im.classify(sent, num_cluster = 3)

# Load terra for raster handling and plotting
library(terra)

# Plot classified raster
plot(class)

# Function to plot class distribution as a barplot
im.barplot <- function(classified_image,
                       perc = FALSE,
                       counts = FALSE,
                       rescale = FALSE,
                       custom_colors = NULL) {
  
  # Check that the input is a SpatRaster
  if (!inherits(classified_image, "SpatRaster")) {
    stop("classified_image should be a SpatRaster.")
  }
  
  # Check that the classified raster has only one layer
  if (terra::nlyr(classified_image) != 1) {
    stop("classified_image should have a single layer.")
  }
  
  # Convert raster values to a data frame
  df <- terra::as.data.frame(classified_image, na.rm = TRUE)
  names(df) <- "class"
  df$class <- as.factor(df$class)
  
  # Count total non-NA pixels
  total_pixels <- nrow(df)
  
  # Build percentage barplot
  if (isTRUE(perc)) {
    p <- ggplot2::ggplot(df, ggplot2::aes(x = class, fill = class)) +
      ggplot2::geom_bar(
        ggplot2::aes(y = ggplot2::after_stat(count / sum(count) * 100))
      )
    
    # Add percentage labels if requested
    if (isTRUE(counts)) {
      p <- p +
        ggplot2::geom_text(
          stat = "count",
          ggplot2::aes(
            y = ggplot2::after_stat(count / sum(count) * 100),
            label = round(ggplot2::after_stat(count / sum(count) * 100), 2),
            colour = class
          ),
          vjust = -0.3,
          size = 3,
          show.legend = FALSE
        )
    }
    
    p <- p + ggplot2::labs(x = "Class", y = "Percentage")
    
    # Force y-axis from 0 to 100 if requested
    if (isTRUE(rescale)) {
      p <- p + ggplot2::scale_y_continuous(limits = c(0, 100))
    }
    
  } else {
    # Build pixel-count barplot
    p <- ggplot2::ggplot(df, ggplot2::aes(x = class, fill = class)) +
      ggplot2::geom_bar()
    
    # Add count labels if requested
    if (isTRUE(counts)) {
      p <- p +
        ggplot2::geom_text(
          stat = "count",
          ggplot2::aes(label = ggplot2::after_stat(count), colour = class),
          vjust = -0.3,
          size = 3,
          show.legend = FALSE
        )
    }
    
    p <- p + ggplot2::labs(x = "Class", y = "Number of pixels")
    
    # Force y-axis from 0 to total pixels if requested
    if (isTRUE(rescale)) {
      p <- p + ggplot2::scale_y_continuous(limits = c(0, total_pixels))
    }
  }
  
  # Apply custom color palette if supplied
  if (!is.null(custom_colors)) {
    if (!is.character(custom_colors)) {
      stop("custom_colors must be a character vector of valid color names or hex codes.")
    }
    
    n_classes <- nlevels(df$class)
    pal <- grDevices::colorRampPalette(custom_colors)(n_classes)
    
    p <- p +
      ggplot2::scale_fill_manual(values = pal) +
      ggplot2::scale_colour_manual(values = pal)
  }
  
  # Hide legends
  p <- p +
    ggplot2::guides(fill = "none", colour = "none")
  
  return(p)
}

# Function to visualize raster values by class using boxplots
im.boxplot <- function(input_image, classified_image, 
                       layer = 1,
                       density = TRUE,
                       median_labels = FALSE,
                       legend = FALSE,
                       limits = NULL,
                       custom_colors = NULL) {
  
  # Check that input image is a SpatRaster
  if (!inherits(input_image, "SpatRaster")) {
    stop("input_image should be a SpatRaster object.")
  }
  
  # Check that classified image is a SpatRaster
  if (!inherits(classified_image, "SpatRaster")) {
    stop("classified_image should be a SpatRaster object.")
  }
  
  # Check that classification raster has one layer
  if (terra::nlyr(classified_image) != 1) {
    stop("classified_image should have a single layer.")
  }
  
  # Select layer by numeric index or layer name
  if (is.numeric(layer)) {
    if (layer < 1 || layer > terra::nlyr(input_image)) {
      stop("layer exceeds the number of layers in input_image.")
    }
    layer_name <- names(input_image)[layer]
    layer_rast <- input_image[[layer]]
    
  } else if (is.character(layer)) {
    if (!layer %in% names(input_image)) {
      stop("layer name not found in input_image.")
    }
    layer_name <- layer
    layer_rast <- input_image[[layer]]
    
  } else {
    stop("layer must be either a numeric index or a layer name.")
  }
  
  # Combine selected raster layer and class raster into a data frame
  df <- terra::as.data.frame(c(layer_rast, classified_image), na.rm = TRUE)
  names(df) <- c("value", "Class")
  df$Class <- as.factor(df$Class)
  
  # Build base boxplot
  p <- ggplot2::ggplot(
    data = df,
    mapping = ggplot2::aes(x = Class, y = value, colour = Class)
  ) +
    ggplot2::geom_boxplot(
      width = 0.30,
      outlier.shape = NA,
      outlier.color = NA
    ) +
    ggplot2::labs(y = layer_name)
  
  # Add half-eye density plots if requested
  if (isTRUE(density)) {
    p <- p +
      ggdist::stat_halfeye(
        ggplot2::aes(fill = Class),
        adjust = 0.5,
        width = 0.5,
        .width = 0,
        justification = -0.4,
        point_colour = NA,
        alpha = 0.5
      )
  }
  
  # Add median labels if requested
  if (isTRUE(median_labels)) {
    p <- p +
      ggplot2::stat_summary(
        fun = "median",
        geom = "text",
        size = 3,
        ggplot2::aes(label = round(ggplot2::after_stat(y), 3)),
        position = ggplot2::position_nudge(x = -0.3)
      )
  }
  
  # Restrict y-axis to selected quantile limits if provided
  if (!is.null(limits)) {
    if (!is.numeric(limits) || length(limits) != 2) {
      stop("limits must be a numeric vector of length 2.")
    }
    if (any(limits < 0 | limits > 1)) {
      stop("limits must contain quantile probabilities between 0 and 1.")
    }
    
    p <- p +
      ggplot2::scale_y_continuous(
        limits = stats::quantile(df$value, probs = limits, na.rm = TRUE)
      )
  }
  
  # Apply custom colors if supplied
  if (!is.null(custom_colors)) {
    if (!is.character(custom_colors)) {
      stop("custom_colors must be a character vector of valid color names or hex codes.")
    }
    
    n_classes <- nlevels(df$Class)
    pal <- grDevices::colorRampPalette(custom_colors)(n_classes)
    
    p <- p + ggplot2::scale_colour_manual(values = pal)
    
    if (isTRUE(density)) {
      p <- p + ggplot2::scale_fill_manual(values = pal)
    }
  }
  
  # Hide legend unless requested
  if (!isTRUE(legend)) {
    p <- p +
      ggplot2::guides(colour = "none", fill = "none")
  }
  
  return(p)
}

# Plot spectral distribution of band 4 by class
im.boxplot(
  sent, class, layer = 4,
  density = TRUE,
  median_labels = TRUE,
  legend = FALSE,
  limits = c(0.01, 0.99), 
  custom_colors = viridis::viridis(4, end = 0.5)
)

# Plot percentage distribution of classes
im.barplot(class, perc = TRUE, counts = TRUE, rescale = TRUE)

# Load packages for plot composition and RGB plotting
library(patchwork)
library(RStoolbox)

# Create RGB composites
ggRGB(sent, 2, 4, 3)
ggRGB(sent, 2, 4, 3, stretch = "lin")

# Save RGB composite and classified image plot
p1 <- ggRGB(sent, 2, 4, 3, stretch = "lin")
p2 <- im.ggplot(class)

# Combine RGB and classification plots
p1 + p2

# Create boxplot of band 4 values grouped by classes
p3 <- im.boxplot(
  sent, class, layer = 4,
  density = TRUE,
  median_labels = TRUE,
  legend = FALSE,
  limits = c(0.01, 0.99), 
  custom_colors = viridis::viridis(4, end = 0.5)
)

# Create barplot of class percentages
p4 <- im.barplot(class, perc = TRUE, counts = TRUE, rescale = TRUE)

# Combine all plots
p1 + p2 + p3 + p4

# Load ggplot2 for custom raster plotting
library(ggplot2)

# Reclassify Sentinel image into 3 classes without plotting
class_raster <- im.classify(sent, num_clusters = 3, do_plot = FALSE)

# Convert classified raster to data frame with coordinates
df <- as.data.frame(class_raster, xy = TRUE, na.rm = TRUE)
colnames(df)[3] <- "class"

# Plot classified raster with manual colors
ggplot(df, aes(x = x, y = y, fill = factor(class))) +
  geom_raster() +
  scale_fill_manual(
    values = c("khaki", "slateblue", "olivedrab"),
    name = "Class"
  ) +
  coord_equal() +
  theme_minimal()

# Plot classified raster without additional theme
ggplot(df, aes(x = x, y = y, fill = factor(class))) +
  geom_raster() +
  scale_fill_manual(
    values = c("khaki", "slateblue", "olivedrab"),
    name = "Class"
  ) +
  coord_equal()

# Plot classified raster with viridis palette and empty theme
ggplot(df, aes(x = x, y = y, fill = factor(class))) +
  geom_raster() +
  scale_fill_viridis_d(name = "Class") +
  coord_equal() +
  theme_void()

# Plot classified raster with viridis palette
ggplot(df, aes(x = x, y = y, fill = factor(class))) +
  geom_raster() +
  scale_fill_viridis_d(name = "Class") +
  coord_equal()

# Save viridis classified raster plot
p5 <- ggplot(df, aes(x = x, y = y, fill = factor(class))) +
  geom_raster() +
  scale_fill_viridis_d(name = "Class") +
  coord_equal()

# Combine RGB plot, classification map, boxplot, and barplot
p1 + p5 + p3 + p4

# Create ridgeline plot with mako palette
p6 <- im.ridgeline(sent, scale = 2, palette = "mako")

# Combine plots using different layouts/orders
p1 + p6 + p3 + p4
p1 + p6 + p4 + p3

# Load viridis color palette
library(viridis)

# Define three class colors
class_cols <- viridis(3, end = 0.5)

# Recreate boxplot using matching class colors
p3 <- im.boxplot(
  sent, class, layer = 4,
  density = TRUE,
  median_labels = TRUE,
  legend = FALSE,
  limits = c(0.01, 0.99),
  custom_colors = class_cols
)

# Recreate barplot using matching class colors
p4 <- im.barplot(
  class,
  perc = TRUE,
  counts = TRUE,
  rescale = TRUE,
  custom_colors = class_cols
)

# Combine plots with consistent color palette
p1 + p6 + p4 + p3

# Redefine im.barplot using outlined bars instead of filled bars
im.barplot <- function(classified_image,
                       perc = FALSE,
                       counts = FALSE,
                       rescale = FALSE,
                       custom_colors = NULL) {
  
  # Check that input is a SpatRaster
  if (!inherits(classified_image, "SpatRaster")) {
    stop("classified_image should be a SpatRaster.")
  }
  
  # Check that classified raster has one layer
  if (terra::nlyr(classified_image) != 1) {
    stop("classified_image should have a single layer.")
  }
  
  # Extract class values
  df <- terra::as.data.frame(classified_image, na.rm = TRUE)
  names(df) <- "class"
  df$class <- as.factor(df$class)
  
  # Count total pixels
  total_pixels <- nrow(df)
  
  # Build percentage barplot with outlined bars
  if (isTRUE(perc)) {
    p <- ggplot2::ggplot(df, ggplot2::aes(x = class, colour = class)) +
      ggplot2::geom_bar(
        ggplot2::aes(y = ggplot2::after_stat(count / sum(count) * 100)),
        fill = NA,
        linewidth = 1
      )
    
    # Add percentage labels if requested
    if (isTRUE(counts)) {
      p <- p +
        ggplot2::geom_text(
          stat = "count",
          ggplot2::aes(
            y = ggplot2::after_stat(count / sum(count) * 100),
            label = round(ggplot2::after_stat(count / sum(count) * 100), 2),
            colour = class
          ),
          vjust = -0.3,
          size = 3,
          show.legend = FALSE
        )
    }
    
    p <- p + ggplot2::labs(x = "Class", y = "Percentage")
    
    # Force percentage axis from 0 to 100
    if (isTRUE(rescale)) {
      p <- p + ggplot2::scale_y_continuous(limits = c(0, 100))
    }
    
  } else {
    # Build count barplot with outlined bars
    p <- ggplot2::ggplot(df, ggplot2::aes(x = class, colour = class)) +
      ggplot2::geom_bar(
        fill = NA,
        linewidth = 1
      )
    
    # Add count labels if requested
    if (isTRUE(counts)) {
      p <- p +
        ggplot2::geom_text(
          stat = "count",
          ggplot2::aes(label = ggplot2::after_stat(count), colour = class),
          vjust = -0.3,
          size = 3,
          show.legend = FALSE
        )
    }
    
    p <- p + ggplot2::labs(x = "Class", y = "Number of pixels")
    
    # Force count axis from 0 to total pixels
    if (isTRUE(rescale)) {
      p <- p + ggplot2::scale_y_continuous(limits = c(0, total_pixels))
    }
  }
  
  # Apply custom outline colors
  if (!is.null(custom_colors)) {
    if (!is.character(custom_colors)) {
      stop("custom_colors must be a character vector of valid color names or hex codes.")
    }
    
    n_classes <- nlevels(df$class)
    pal <- grDevices::colorRampPalette(custom_colors)(n_classes)
    
    p <- p + ggplot2::scale_colour_manual(values = pal)
  }
  
  # Hide colour legend
  p <- p + ggplot2::guides(colour = "none")
  
  return(p)
}

# Define class colors again
class_cols <- viridis::viridis(3, end = 0.5)

# Create final outlined class-distribution barplot
p4 <- im.barplot(
  class,
  perc = TRUE,
  counts = TRUE,
  rescale = TRUE,
  custom_colors = class_cols
)

# Combine final plots
p1 + p6 + p4 + p3
