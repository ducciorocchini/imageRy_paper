# imageRy paper
Code for the paper on the imageRy package

# Workflow of sections and functions

- section: Data import and visualization, functions: im.list() im.import() im.plotRGB() 
- section: Functions related to data analysis
  - subsection Qualitative multitemporal analysis with data visualization, functions: im.plotRGB()
  - subsection Spectral indices, functions: im.dvi() im.ndvi()
  - subsection Quantitative multitemporal analysis: image classification, functions: im.classify()
  - subsection Measuring image variability over space, functions: terra::focal(), im.pca()
  - subsection imageRy in the tidyverse, functions: im.ggplot(), im.ggplotRGB(), im.ridgeline() 
