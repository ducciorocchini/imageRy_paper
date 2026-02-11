# Appendix: Study areas 🌍

This appendix provides brief descriptions of the geographic areas used as case studies in this paper:

*Empowering ecological remote sensing learning: the `imageRy` R package to help students and instructors*

---

## 1. Tofane massif 🏔️ – Sentinel-2 (Level 2A) image from the [Copernicus](https://www.copernicus.eu/en) program, used for Figures 1, 2, 3, 8, 9

> Images names: `sentinel.dolomites.b2.tif`, `sentinel.dolomites.b3.tif`, `sentinel.dolomites.b4.tif`, `sentinel.dolomites.b8.tif`

The **Tofane massif** is a striking mountain group in the **Dolomites of northeastern Italy**, rising above the town of **Cortina d’Ampezzo**. Renowned for its dramatic limestone cliffs, wide alpine plateaus, and historic **World War I sites**, the massif includes its highest peak, **Tofana di Mezzo (3,244 m)**. Today, the Tofane are a major destination for hiking, climbing, and skiing ⛷️🥾, and form part of the **UNESCO World Heritage Dolomites**.

<p align="center">
  <img 
    src="https://github.com/user-attachments/assets/c370f53c-adfe-4f05-8cd1-4dc664f7d827"
    alt="cellulaR"
    width="300"
  />
</p>

Use this JavaScript in Google Earth Engine to replicate the screenshot 🗺️
```
var pt = ee.Geometry.Point(
  [745645, 5163490],
  ee.Projection('EPSG:32632')
);
Map.centerObject(pt, 13);
Map.addLayer(pt, {color: 'red'}, 'Raster center');
```

<img width="1716" height="976" alt="Screenshot 2026-01-19 at 17 14 12" src="https://github.com/user-attachments/assets/5b90e7f2-d76f-493e-b4b1-7b9e8a8cc042" />

---

## 2. Taboca rainforest (Brazil) 🌿 –  – Sentinel-2 (Level 2A) image from the [Copernicus](https://www.copernicus.eu/en) program, used for Figure 4

> image name: `S2_AllBands_tropical.tif`

The **Taboca area**, located along the **Rio Carabinani** in the **Amazonas region of Brazil**, is a remote and largely pristine section of the **Amazon rainforest**. Characterized by dense tropical vegetation, blackwater rivers, and exceptionally rich biodiversity 🐒🦜, the area lies within the broader **Jaú River basin**, recognized for its high ecological value. Taboca is inhabited mainly by traditional riverine communities and plays an important role in conserving Amazonian forest and freshwater ecosystems.

<p align="center">
  <img 
    src="https://github.com/user-attachments/assets/edda925c-d803-4aea-b76e-99ee2a0a9d48"
    alt="cellulaR"
    width="300"
  />
</p>

Use this JavaScript in Google Earth Engine to replicate the screenshot 🗺️
```
var pt = ee.Geometry.Point(
  [-61.917725, -2.5009545],
  ee.Projection('EPSG:4326')
);
Map.centerObject(pt, 13);
Map.addLayer(pt, {color: 'red'}, 'Raster center');
```

<img width="1707" height="983" alt="Screenshot 2026-01-19 at 17 11 55" src="https://github.com/user-attachments/assets/3fbbb210-46ec-4f2e-b602-60161b274df3" />

---

## 3. Passo Falzarego 🌲 – Sentinel-2 (Level 2A) image from the [Copernicus](https://www.copernicus.eu/en) program, used for Figures 5, 6, 7

> image name: `S2_AllBands_temperate_passo_falzarego.tif`

The **temperate mixed forests near Passo Falzarego**, in the **Dolomites of northeastern Italy**, form a diverse mountain landscape between alpine meadows and rugged rocky peaks. These forests are dominated by **spruce, larch, fir, and beech**, creating a heterogeneous mosaic that varies with elevation and season 🍂❄️. Shaped by a cool alpine climate and rich in wildlife, the area also contains significant **World War I historical sites** and supports hiking, nature observation, and traditional mountain land use.

<p align="center">
  <img 
    src="https://github.com/user-attachments/assets/be0be500-889b-4f1c-b985-34fa2f62598f"
    alt="cellulaR"
    width="300"
  />
</p>

Use this JavaScript in Google Earth Engine to replicate the screenshot 🗺️
```
var pt = ee.Geometry.Point(
  [12.136105, 46.494195],
  ee.Projection('EPSG:4326')
);
Map.centerObject(pt, 13);
Map.addLayer(pt, {color: 'red'}, 'Raster center');
```

<img width="1721" height="982" alt="Screenshot 2026-01-19 at 17 12 59" src="https://github.com/user-attachments/assets/0f52fcf7-8d67-4e35-ba8e-08356cb97d29" />

---
