
R version 4.4.2 (2024-10-31) -- "Pile of Leaves"
Copyright (C) 2024 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.81 (8462) aarch64-apple-darwin20]

[Workspace restored from /Users/ducciorocchini/.RData]
[History restored from /Users/ducciorocchini/.Rapp.history]

> library(imageRy)
> ll
Error: object 'll' not found
> im.list()
 [1] "bletterbach.jpg"                                   
 [2] "dolansprings_oli_2013088_canyon_lrg.jpg"           
 [3] "EN_01.png"                                         
 [4] "EN_02.png"                                         
 [5] "EN_03.png"                                         
 [6] "EN_04.png"                                         
 [7] "EN_05.png"                                         
 [8] "EN_06.png"                                         
 [9] "EN_07.png"                                         
[10] "EN_08.png"                                         
[11] "EN_09.png"                                         
[12] "EN_10.png"                                         
[13] "EN_11.png"                                         
[14] "EN_12.png"                                         
[15] "EN_13.png"                                         
[16] "greenland.2000.tif"                                
[17] "greenland.2005.tif"                                
[18] "greenland.2010.tif"                                
[19] "greenland.2015.tif"                                
[20] "info.md"                                           
[21] "iss063e039892_lrg.jpg"                             
[22] "matogrosso_ast_2006209_lrg.jpg"                    
[23] "matogrosso_l5_1992219_lrg.jpg"                     
[24] "NDVI_rainbow_legend.png"                           
[25] "NDVI_rainbow.png"                                  
[26] "S2_AllBands_temperate_passo_falzarego.tif"         
[27] "S2_AllBands_tropical.tif"                          
[28] "sentinel.dolomites.b2.tif"                         
[29] "sentinel.dolomites.b3.tif"                         
[30] "sentinel.dolomites.b4.tif"                         
[31] "sentinel.dolomites.b8.tif"                         
[32] "sentinel.png"                                      
[33] "Sentinel2_NDVI_2020-02-21.tif"                     
[34] "Sentinel2_NDVI_2020-05-21.tif"                     
[35] "Sentinel2_NDVI_2020-08-01.tif"                     
[36] "Sentinel2_NDVI_2020-11-27.tif"                     
[37] "Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"
> sent <- im.import("sentinel.dolomites")
> sent <- im.ridgeline(sent, scale=1)
> sent <- im.import("sentinel.dolomites")
> ridge <- im.import("sentinel.dolomites")
> ridge
class       : SpatRaster 
dimensions  : 934, 1059, 4  (nrow, ncol, nlyr)
resolution  : 10, 10  (x, y)
extent      : 740350, 750940, 5158820, 5168160  (xmin, xmax, ymin, ymax)
coord. ref. : WGS 84 / UTM zone 32N (EPSG:32632) 
sources     : sentinel.dolomites.b2.tif  
              sentinel.dolomites.b3.tif  
              sentinel.dolomites.b4.tif  
              sentinel.dolomites.b8.tif  
names       : sentine~ites.b2, sentine~ites.b3, sentine~ites.b4, sentine~ites.b8 
min values  :            1338,            1293,             750,            1159 
max values  :            6903,            6780,            7229,            7313 
> sent <- im.import("sentinel.dolomites")
> ridge <- im.ridgeline(sent, scale=1)
> ridge
Picking joint bandwidth of 31.6
> ridge <- im.ridgeline(sent, scale=2)
> ridge <- im.ridgeline(sent, scale=4)
> ridge <- im.ridgeline(sent, scale=2)
> ridge
Picking joint bandwidth of 31.6
> class <- im.classify(sent, num_cluster=4)
> class <- im.classify(sent, num_cluster=3)
> class
class       : SpatRaster 
dimensions  : 934, 1059, 1  (nrow, ncol, nlyr)
resolution  : 10, 10  (x, y)
extent      : 740350, 750940, 5158820, 5168160  (xmin, xmax, ymin, ymax)
coord. ref. : WGS 84 / UTM zone 32N (EPSG:32632) 
source(s)   : memory
varname     : sentinel.dolomites.b2 
name        : sentinel.dolomites.b2 
min value   :                     1 
max value   :                     3 
> plot(class)
Error in plot.xy(xy, type, ...) : 
  invalid type passed to graphics function
> class
class       : SpatRaster 
dimensions  : 934, 1059, 1  (nrow, ncol, nlyr)
resolution  : 10, 10  (x, y)
extent      : 740350, 750940, 5158820, 5168160  (xmin, xmax, ymin, ymax)
coord. ref. : WGS 84 / UTM zone 32N (EPSG:32632) 
source(s)   : memory
varname     : sentinel.dolomites.b2 
name        : sentinel.dolomites.b2 
min value   :                     1 
max value   :                     3 
> ?im.classify
starting httpd help server ... done
> plot(class)
Error in plot.xy(xy, type, ...) : 
  invalid type passed to graphics function
> library(terra)
terra 1.8.21
> plot(class)
> sentinel.dolomites
Error: object 'sentinel.dolomites' not found
> #' Plot Class Distribution from a Classified Raster
> #'
> #' This function generates a bar plot summarizing the distribution of classes in a classified raster image.
> #' It can display either absolute pixel counts or percentages, with optional labels and custom color palettes.
> #'
> #' @param classified_image A `SpatRaster` object representing a classified raster with a single layer.
> #' @param perc A logical value indicating whether to plot percentages instead of counts (default: FALSE).
> #' @param counts A logical value indicating whether to display numeric labels above bars (default: FALSE).
> #' @param rescale A logical value indicating whether to rescale the y-axis to full range (default: FALSE).
> #' @param custom_colors A character vector of colors to be used for the bar plot (default: NULL).
> #'
> #' @return A `ggplot` object representing the distribution of classes in the raster.
> #'
> #' @details
> #' The function extracts pixel values from a classified raster and summarizes them as a bar plot.
> #' Each class corresponds to a category, and the height of the bars represents either:
> #' \itemize{
> #'   \item The number of pixels per class (default), or
> #'   \item The percentage of pixels per class (if `perc = TRUE`)
> #' }
> #'
> #' Additional options:
> #' \itemize{
> #'   \item If `counts = TRUE`, numeric values are displayed above each bar.
> #'   \item If `rescale = TRUE`, the y-axis is fixed to the full range (0–100 for percentages or total pixel count).
> #'   \item If `custom_colors` is provided, it is used to define the color palette of the plot.
> #' }
> #'
> #' This function is particularly useful for summarizing the output of unsupervised or supervised classification
> #' and linking spatial patterns to quantitative class proportions.
> #'
> #' @seealso [im.classify()], [im.kernel()]
> #'
> #' @examples
> #' \dontrun{
> #' library(terra)
> #' library(ggplot2)
> #'
> #' # Load example raster
> #' r <- rast(system.file("ex/elev.tif", package = "terra"))
> #'
> #' # Perform classification
> #' classified <- im.classify(r, num_clusters = 3)
> #'
> #' # Plot class distribution
> #' im.barplot(classified, perc = TRUE, counts = TRUE)
> #' }
> #'
> #' @export
> im.barplot <- function(classified_image,
+                        perc = FALSE, # TRUE for bars showing the percentage of pixels per class
+                        counts = FALSE, # TRUE for adding numeric labels above the bars
+                        rescale = FALSE, # TRUE for rescaling the y-axis
+                        custom_colors = NULL) { # add custom colors
+   
+   # Check input
+   if (!inherits(classified_image, "SpatRaster")) {
+     stop("classified_image should be a SpatRaster.")
+   }
+   
+   if (terra::nlyr(classified_image) != 1) {
+     stop("classified_image should have a single layer.")
+   }
+   
+   # Extract values
+   df <- terra::as.data.frame(classified_image, na.rm = TRUE)
+   names(df) <- "class"
+   df$class <- as.factor(df$class)
+   
+   # Total number of pixels
+   total_pixels <- nrow(df)
+   
+   # Basic plot
+   if (isTRUE(perc)) {
+     p <- ggplot2::ggplot(df, ggplot2::aes(x = class, fill = class)) +
+       ggplot2::geom_bar(ggplot2::aes(y = ggplot2::after_stat(count / sum(count) * 100)))
+     
+     if (isTRUE(counts)) {
+       p <- p +
+         ggplot2::geom_text(
+           stat = "count",
+           ggplot2::aes(
+             y = ggplot2::after_stat(count / sum(count) * 100),
+             label = round(ggplot2::after_stat(count / sum(count) * 100), 2),
+             colour = class
+           ),
+           vjust = -0.3,
+           size = 3,
+           show.legend = FALSE
+         )
+     }
+     
+     p <- p + ggplot2::labs(x = "Class", y = "Percentage")
+     
+     if (isTRUE(rescale)) {
+       p <- p + ggplot2::scale_y_continuous(limits = c(0, 100))
+     }
+     
+   } else {
+     p <- ggplot2::ggplot(df, ggplot2::aes(x = class, fill = class)) +
+       ggplot2::geom_bar()
+     
+     if (isTRUE(counts)) {
+       p <- p +
+         ggplot2::geom_text(
+           stat = "count",
+           ggplot2::aes(label = ggplot2::after_stat(count), colour = class),
+           vjust = -0.3,
+           size = 3,
+           show.legend = FALSE
+         )
+     }
+     
+     p <- p + ggplot2::labs(x = "Class", y = "Number of pixels")
+     
+     if (isTRUE(rescale)) {
+       p <- p + ggplot2::scale_y_continuous(limits = c(0, total_pixels))
+     }
+   }
+   
+   # Optional custom colors
+   if (!is.null(custom_colors)) {
+     if (!is.character(custom_colors)) {
+       stop("custom_colors must be a character vector of valid color names or hex codes.")
+     }
+     
+     n_classes <- nlevels(df$class)
+     pal <- grDevices::colorRampPalette(custom_colors)(n_classes)
+     
+     p <- p +
+       ggplot2::scale_fill_manual(values = pal) +
+       ggplot2::scale_colour_manual(values = pal)
+   }
+   
+   # Final plot
+   p <- p +
+     ggplot2::guides(fill = "none", colour = "none")
+   
+   return(p)
+ }
> 
> 
> im.boxplot(dolom, classes, layer = 4,
+            density = TRUE,
+            median_labels = TRUE,
+            legend = FALSE,
+            limits = c(0.01, 0.99), 
+            custom_colors = viridis::viridis(4, end = 0.5))
Error in im.boxplot(dolom, classes, layer = 4, density = TRUE, median_labels = TRUE,  : 
  could not find function "im.boxplot"
> #' Visualize Spectral Distributions Across Classes Using Boxplots
> #'
> #' This function generates boxplots of raster values grouped by classes derived from a classified image.
> #' It allows comparison of spectral distributions across classes, with optional density overlays,
> #' median labels, and custom visualization settings.
> #'
> #' @param input_image A `SpatRaster` object representing the input raster (single or multi-layer).
> #' @param classified_image A `SpatRaster` object with a single layer representing class assignments.
> #' @param layer A numeric index or character string specifying which layer of `input_image` to visualize (default: 1).
> #' @param density A logical value indicating whether to overlay half-eye density plots (default: TRUE).
> #' @param median_labels A logical value indicating whether to display median values on the plot (default: FALSE).
> #' @param legend A logical value indicating whether to display the legend (default: FALSE).
> #' @param limits A numeric vector of length 2 specifying quantile limits (between 0 and 1) for the y-axis (default: NULL).
> #' @param custom_colors A character vector specifying colors for the classes (default: NULL).
> #'
> #' @return A `ggplot` object showing the distribution of pixel values per class.
> #'
> #' @details
> #' The function combines spectral information from a raster image with class assignments
> #' from a classified raster to visualize how pixel values are distributed across classes.
> #'
> #' Each class is represented by a boxplot summarizing:
> #' \itemize{
> #'   \item Median values
> #'   \item Interquartile range (IQR)
> #'   \item Distribution spread (excluding outliers by default)
> #' }
> #'
> #' Optional density overlays (half-eye plots) provide a smoothed representation of the
> #' distribution, facilitating interpretation of class separability in spectral space.
> #'
> #' Additional options:
> #' \itemize{
> #'   \item `density = TRUE` overlays kernel density estimates for each class.
> #'   \item `median_labels = TRUE` annotates each class with its median value.
> #'   \item `limits` restricts the y-axis to selected quantiles, improving visualization of central distributions.
> #'   \item `custom_colors` allows user-defined color palettes for classes.
> #' }
> #'
> #' From an informatics perspective, this function provides a link between classification outputs
> #' and spectral feature space, enabling the evaluation of class separability and internal variability.
> #' It supports interpretation of classification results by explicitly showing how pixel values are
> #' distributed within and across classes.
> #'
> #' @seealso [im.classify()], [im.barplot()]
> #'
> #' @examples
> #' \dontrun{
> #' library(terra)
> #' library(ggplot2)
> #'
> #' # Load example raster
> #' r <- rast(system.file("ex/elev.tif", package = "terra"))
> #'
> #' # Perform classification
> #' classified <- im.classify(r, num_clusters = 3)
> #'
> #' # Plot spectral distributions for layer 1
> #' im.boxplot(r, classified, layer = 1, density = TRUE)
> #' }
> #'
> #' @export
> im.boxplot <- function(input_image, classified_image, 
+                        layer = 1, # specify the layer to be displayed
+                        density = TRUE, # TRUE for adding a half-eye density plot 
+                        median_labels = FALSE, # TRUE for adding median labels
+                        legend = FALSE, # TRUE for adding a legend
+                        limits = NULL, # restrict the visible y-axis range to selected quantiles
+                        custom_colors = NULL) { # specify a color palette
+   
+   # Check input image
+   if (!inherits(input_image, "SpatRaster")) {
+     stop("input_image should be a SpatRaster object.")
+   }
+   
+   # Check classified image
+   if (!inherits(classified_image, "SpatRaster")) {
+     stop("classified_image should be a SpatRaster object.")
+   }
+   
+   if (terra::nlyr(classified_image) != 1) {
+     stop("classified_image should have a single layer.")
+   }
+   
+   # Select layer by index or name
+   if (is.numeric(layer)) {
+     if (layer < 1 || layer > terra::nlyr(input_image)) {
+       stop("layer exceeds the number of layers in input_image.")
+     }
+     layer_name <- names(input_image)[layer]
+     layer_rast <- input_image[[layer]]
+     
+   } else if (is.character(layer)) {
+     if (!layer %in% names(input_image)) {
+       stop("layer name not found in input_image.")
+     }
+     layer_name <- layer
+     layer_rast <- input_image[[layer]]
+     
+   } else {
+     stop("layer must be either a numeric index or a layer name.")
+   }
+   
+   # Build the  data frame
+   df <- terra::as.data.frame(c(layer_rast, classified_image), na.rm = TRUE)
+   names(df) <- c("value", "Class")
+   df$Class <- as.factor(df$Class)
+   
+   # Basic plot
+   p <- ggplot2::ggplot(
+     data = df,
+     mapping = ggplot2::aes(x = Class, y = value, colour = Class)
+   ) +
+     ggplot2::geom_boxplot(
+       width = 0.30,
+       outlier.shape = NA,
+       outlier.color = NA
+     ) +
+     ggplot2::labs(y = layer_name)
+   
+   # Optional density layer
+   if (isTRUE(density)) {
+     p <- p +
+       ggdist::stat_halfeye(
+         ggplot2::aes(fill = Class),
+         adjust = 0.5,
+         width = 0.5,
+         .width = 0,
+         justification = -0.4,
+         point_colour = NA,
+         alpha = 0.5
+       )
+   }
+   
+   # Optional median labels
+   if (isTRUE(median_labels)) {
+     p <- p +
+       ggplot2::stat_summary(
+         fun = "median",
+         geom = "text",
+         size = 3,
+         ggplot2::aes(label = round(ggplot2::after_stat(y), 3)),
+         position = ggplot2::position_nudge(x = -0.3)
+       )
+   }
+   
+   # Optional quantile limits
+   if (!is.null(limits)) {
+     if (!is.numeric(limits) || length(limits) != 2) {
+       stop("limits must be a numeric vector of length 2.")
+     }
+     if (any(limits < 0 | limits > 1)) {
+       stop("limits must contain quantile probabilities between 0 and 1.")
+     }
+     
+     p <- p +
+       ggplot2::scale_y_continuous(
+         limits = stats::quantile(df$value, probs = limits, na.rm = TRUE)
+       )
+   }
+   
+   # Optional custom colors
+   if (!is.null(custom_colors)) {
+     if (!is.character(custom_colors)) {
+       stop("custom_colors must be a character vector of valid color names or hex codes.")
+     }
+     
+     n_classes <- nlevels(df$Class)
+     pal <- grDevices::colorRampPalette(custom_colors)(n_classes)
+     
+     p <- p + ggplot2::scale_colour_manual(values = pal)
+     
+     if (isTRUE(density)) {
+       p <- p + ggplot2::scale_fill_manual(values = pal)
+     }
+   }
+   
+   # Optional legend
+   if (!isTRUE(legend)) {
+     p <- p +
+       ggplot2::guides(colour = "none", fill = "none")
+   }
+   
+   return(p)
+ }
> 
> im.boxplot(dolom, classes, layer = 4,
+            density = TRUE,
+            median_labels = TRUE,
+            legend = FALSE,
+            limits = c(0.01, 0.99), 
+            custom_colors = viridis::viridis(4, end = 0.5))
Error: object 'dolom' not found
> im.boxplot(class, classes, layer = 4,
+            density = TRUE,
+            median_labels = TRUE,
+            legend = FALSE,
+            limits = c(0.01, 0.99), 
+            custom_colors = viridis::viridis(4, end = 0.5))
Error: object 'classes' not found
> im.boxplot(sent, class, layer = 4,
+            density = TRUE,
+            median_labels = TRUE,
+            legend = FALSE,
+            limits = c(0.01, 0.99), 
+            custom_colors = viridis::viridis(4, end = 0.5))
Warning messages:
1: Removed 19714 rows containing non-finite outside
the scale range (`stat_boxplot()`). 
2: Removed 19714 rows containing missing values or
values outside the scale range
(`stat_slabinterval()`). 
3: Removed 19714 rows containing non-finite outside
the scale range (`stat_summary()`). 
> 
> im.barplot <- function(classified_image,
+                        perc = FALSE, # TRUE for bars showing the percentage of pixels per class
+                        counts = FALSE, # TRUE for adding numeric labels above the bars
+                        rescale = FALSE, # TRUE for rescaling the y-axis
+                        custom_colors = NULL) { # add custom colors
+   
+   # Check input
+   if (!inherits(classified_image, "SpatRaster")) {
+     stop("classified_image should be a SpatRaster.")
+   }
+   
+   if (terra::nlyr(classified_image) != 1) {
+     stop("classified_image should have a single layer.")
+   }
+   
+   # Extract values
+   df <- terra::as.data.frame(classified_image, na.rm = TRUE)
+   names(df) <- "class"
+   df$class <- as.factor(df$class)
+   
+   # Total number of pixels
+   total_pixels <- nrow(df)
+   
+   # Basic plot
+   if (isTRUE(perc)) {
+     p <- ggplot2::ggplot(df, ggplot2::aes(x = class, fill = class)) +
+       ggplot2::geom_bar(ggplot2::aes(y = ggplot2::after_stat(count / sum(count) * 100)))
+     
+     if (isTRUE(counts)) {
+       p <- p +
+         ggplot2::geom_text(
+           stat = "count",
+           ggplot2::aes(
+             y = ggplot2::after_stat(count / sum(count) * 100),
+             label = round(ggplot2::after_stat(count / sum(count) * 100), 2),
+             colour = class
+           ),
+           vjust = -0.3,
+           size = 3,
+           show.legend = FALSE
+         )
+     }
+     
+     p <- p + ggplot2::labs(x = "Class", y = "Percentage")
+     
+     if (isTRUE(rescale)) {
+       p <- p + ggplot2::scale_y_continuous(limits = c(0, 100))
+     }
+     
+   } else {
+     p <- ggplot2::ggplot(df, ggplot2::aes(x = class, fill = class)) +
+       ggplot2::geom_bar()
+     
+     if (isTRUE(counts)) {
+       p <- p +
+         ggplot2::geom_text(
+           stat = "count",
+           ggplot2::aes(label = ggplot2::after_stat(count), colour = class),
+           vjust = -0.3,
+           size = 3,
+           show.legend = FALSE
+         )
+     }
+     
+     p <- p + ggplot2::labs(x = "Class", y = "Number of pixels")
+     
+     if (isTRUE(rescale)) {
+       p <- p + ggplot2::scale_y_continuous(limits = c(0, total_pixels))
+     }
+   }
+   
+   # Optional custom colors
+   if (!is.null(custom_colors)) {
+     if (!is.character(custom_colors)) {
+       stop("custom_colors must be a character vector of valid color names or hex codes.")
+     }
+     
+     n_classes <- nlevels(df$class)
+     pal <- grDevices::colorRampPalette(custom_colors)(n_classes)
+     
+     p <- p +
+       ggplot2::scale_fill_manual(values = pal) +
+       ggplot2::scale_colour_manual(values = pal)
+   }
+   
+   # Final plot
+   p <- p +
+     ggplot2::guides(fill = "none", colour = "none")
+   
+   return(p)
+ }
> 
> im.barplot(classes, perc = TRUE, counts = TRUE, rescale = TRUE)
Error: object 'classes' not found
> 
> im.barplot(class, perc = TRUE, counts = TRUE, rescale = TRUE)
> library(patchwork)

Attaching package: ‘patchwork’

The following object is masked from ‘package:terra’:

    area

> p1 = im.ggplotRGB(sent, 3,4,2)
> p1
Error in `geom_raster()`:
! Problem while computing aesthetics.
ℹ Error occurred in the 1st layer.
Caused by error in `get()`:
! object 'NA' not found
Run `rlang::last_trace()` to see where the error occurred.
> ?im.ggplotRGB
> p1 = im.ggplotRGB(sent, 3,4,2, stretch="lin")
> p1
Error in `geom_raster()`:
! Problem while computing aesthetics.
ℹ Error occurred in the 1st layer.
Caused by error in `get()`:
! object 'NA' not found
Run `rlang::last_trace()` to see where the error occurred.
> library(RStoolbox)
This is version 1.0.2.1 of RStoolbox
> ggRGB(sent, 2,4,3)
> ggRGB(sent, 2,4,3, stretch="lin")
> p1 = ggRGB(sent, 2,4,3, stretch="lin")
> p2 = im.ggplot(class)
> p1 + p2
> p3 =  im.boxplot(sent, class, layer = 4,
+             density = TRUE,
+             median_labels = TRUE,
+             legend = FALSE,
+             limits = c(0.01, 0.99), 
+             custom_colors = viridis::viridis(4, end = 0.5))
> p3
Warning messages:
1: Removed 19714 rows containing non-finite outside
the scale range (`stat_boxplot()`). 
2: Removed 19714 rows containing missing values or
values outside the scale range
(`stat_slabinterval()`). 
3: Removed 19714 rows containing non-finite outside
the scale range (`stat_summary()`). 
> p4 =  im.barplot(classes, perc = TRUE, counts = TRUE, rescale = TRUE)
Error: object 'classes' not found
> p4 =  im.barplot(class, perc = TRUE, counts = TRUE, rescale = TRUE)
> p1 + p2 + p3 + p4 
Warning messages:
1: Removed 19714 rows containing non-finite outside
the scale range (`stat_boxplot()`). 
2: Removed 19714 rows containing missing values or
values outside the scale range
(`stat_slabinterval()`). 
3: Removed 19714 rows containing non-finite outside
the scale range (`stat_summary()`). 
> cols <- c("khaki", "slateblue", "olivedrab")
> 
> ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_manual(values = cols) +
+   coord_equal() +
+   theme_void()
Error in ggplot(df, aes(x = x, y = y, fill = factor(class))) : 
  could not find function "ggplot"
> library(ggplot2)
> cols <- c("khaki", "slateblue", "olivedrab")
> 
> ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_manual(values = cols) +
+   coord_equal() +
+   theme_void()
Error in `ggplot()`:
! `data` cannot be a function.
ℹ Have you misspelled the `data` argument in
  `ggplot()`
Run `rlang::last_trace()` to see where the error occurred.
> 
> 
> df <- as.data.frame(class_raster, xy = TRUE, na.rm = TRUE)
Error in h(simpleError(msg, call)) : 
  error in evaluating the argument 'x' in selecting a method for function 'as.data.frame': object 'class_raster' not found
> colnames(df)[3] <- "class"
Error in `colnames<-`(`*tmp*`, value = c(NA, NA, "class")) : 
  attempt to set 'colnames' on an object with less than two dimensions
> class_raster <- im.classify(sent, num_clusters = 3, do_plot = FALSE)
> library(terra)
> library(ggplot2)
> 
> df <- as.data.frame(class_raster, xy = TRUE, na.rm = TRUE)
> colnames(df)[3] <- "class"
> ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_manual(
+     values = c("khaki", "slateblue", "olivedrab"),
+     name = "Class"
+   ) +
+   coord_equal() +
+   theme_minimal()
> ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_manual(
+     values = c("khaki", "slateblue", "olivedrab"),
+     name = "Class"
+   ) +
+   coord_equal() 
> ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_viridis_d(name = "Class") +
+   coord_equal() +
+   theme_void()
> ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_viridis_d(name = "Class") +
+   coord_equal()
> p5 = ggplot(df, aes(x = x, y = y, fill = factor(class))) +
+   geom_raster() +
+   scale_fill_viridis_d(name = "Class") +
+   coord_equal()
> p5
> p1 + p5 + p3 + p4
Warning messages:
1: Removed 19714 rows containing non-finite outside
the scale range (`stat_boxplot()`). 
2: Removed 19714 rows containing missing values or
values outside the scale range
(`stat_slabinterval()`). 
3: Removed 19714 rows containing non-finite outside
the scale range (`stat_summary()`). 
> 
