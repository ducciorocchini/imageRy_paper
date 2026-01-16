# imageRy paper
Code for the paper on the imageRy package

---

## Repository structure

This repository contains the code and documentation needed to reproduce the analyses and figures presented in the paper.

```
imageRy_paper/
├── Code.R
├── README.md
└── Study_areas.md
```

### File descriptions

* **`README.md`**
  Provides an overview of the repository and its purpose. It summarizes the paper workflow and explains how the code relates to the manuscript.

* **`Code.R`**
  Main R script reproducing all analyses and figures shown in the paper.
  The script follows the same logical order as the manuscript sections, from image visualization to spectral indices, image classification, spatial variability, and multivariate analysis.

* **`Study_areas.md`**
  Describes the study areas and example datasets used in the paper, providing geographical and ecological context for the remote sensing analyses.

---

# Workflow of sections and functions

---

## Workflow of the paper

This repository reproduces the complete analytical workflow presented in the paper *“Empowering ecological remote sensing learning: the imageRy R package to help students and instructors”*.
The workflow follows the same logical sequence as the manuscript sections, moving from image visualization to increasingly advanced ecological analyses.

### 1. Data import and visualization (Section 3)

* Import lightweight Sentinel-2 and other freely available remote sensing images included in the **imageRy** package.
* Visualize single bands using perceptually uniform, color-blind-friendly palettes.
* Combine multiple bands into RGB composites, including false-color representations using the NIR band.
* Purpose: introduce spectral information and support visual interpretation of landscape features.

### 2. Spectral indices (Section 4.1)

* Compute vegetation indices such as:

  * Difference Vegetation Index (DVI)
  * Normalized Difference Vegetation Index (NDVI)
* Apply indices to multispectral images to highlight spatial patterns of vegetation biomass and vigor.
* Compare raw RGB imagery with index-based maps.
* Purpose: translate multispectral reflectance data into ecologically meaningful indicators.

### 3. Image classification (Section 4.2)

* Perform unsupervised image classification using a subset of spectral bands (blue, green, red, NIR).
* Produce discrete land-cover maps representing major ecological components (e.g. vegetation, bare soil/rock, shadow).
* Support interpretation through:

  * RGB comparison
  * Spectral feature-space exploration
  * Class proportion estimates
* Purpose: link continuous spectral data to categorical ecological entities.

### 4. Measuring spatial variability (Section 4.3)

* Quantify spatial heterogeneity by computing local variability (standard deviation) using a moving window.
* Apply variability metrics to:

  * Individual spectral bands (e.g. NIR)
  * Multivariate products (see Section 4.4)
* Identify geomorphological complexity (e.g. rocky areas) and ecological transitions (e.g. forest–grassland ecotones).
* Purpose: measure landscape heterogeneity as a proxy for geomorphological and ecological diversity.

### 5. Multivariate analysis (Section 4.4)

* Reduce multispectral data dimensionality using Principal Component Analysis (PCA).
* Identify the most informative components (typically PC1).
* Use the leading component as an objective input for variability analysis.
* Purpose: summarize multispectral information and avoid subjective band selection.

### 6. Ecological interpretation and teaching perspective (Section 5)

* Integrate visualization, indices, classification, and variability into a coherent learning workflow.
* Emphasize reproducibility, transparency, and accessibility using Free and Open Source Software.
* Highlight links to biodiversity monitoring, ecosystem structure, and landscape heterogeneity.

---

## Compact analysis workflow

This repository reproduces the analysis workflow presented in the paper, using the **imageRy** R package and included Sentinel-2 imagery.

1. **Data import & visualization**
   Import images and visualize single bands and RGB / false-color composites.

2. **Spectral indices**
   Compute DVI and NDVI to highlight spatial patterns of vegetation biomass and vigor.

3. **Image classification**
   Perform unsupervised classification to map major land-cover components and estimate class proportions.

4. **Spatial variability**
   Measure local spectral variability using moving-window statistics to quantify landscape heterogeneity.

5. **Multivariate analysis**
   Apply PCA to summarize multispectral information and objectively support variability analysis.

---

