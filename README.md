# SAM-Melt_EA v5.0

## How Does the Southern Annular Mode Control Surface Melt in East Antarctica?

The notebooks in this repository contain R code that has been used to investigate the influence of the Southern Annular Mode (SAM) on surface melt in East Antarctica.
This work has been undertaken as part of my PhD with the [Monash Ice Sheet Initiative](https://www.icesheet.org/) and [SAEF](https://arcsaef.com) at [Monash University](https://www.monash.edu/science/schools/earth-atmosphere-environment/our-people). 

An accompanying manuscript has been submitted and is currently under consideration.

The code in this repository is being shared in the interests of transparency and open science, and can be used to recreate the figures found in the manuscript and its supporting information. 

**Updates**:
- Version v5.0 makes some minor changes to the formatting of the figures from v4.1 following the first stage of the peer review process. 
- Version v4.1 corrects an error in v4.0 that meant ice shelves were labelled west-to-east in Figure 2, but plotted east-to-west. They are now both labelled and plotted west-to-east.
---

## General Overview of the Repository
This project uses the R programming language and was written using RStudio, on both Windows 10 and MacOS 14.1.
It uses the [renv](https://rstudio.github.io/renv/articles/renv.html) package to help with portability / replicability.

Using _renv_ should be easy enough: after getting the repository onto your system (e.g. `git clone`, or just downloading the ZIP), launch the R Project into RStudio by double-clicking the `SAM-Melt_EA.Rproj` file, and _renv_ should be automatically installed (if necessary) and loaded into the memory.
You can then use `renv::restore()` to recreate the R environment; this function will automatically download or update the necessary packages for you.
See also [here](https://rstudio.github.io/renv/articles/collaborating.html) and [here](https://rpubs.com/glennwithtwons/reproducible-r-toolbox) for info about _renv_.

*Note:* In addition to standard packages from CRAN, it will be necessary to install 5 packages from my [GitHub](https://github.com/polarSaunderson?tab=repositories) page (see "Necessary Personal Packages" below); _renv_ **should** also do this for you.

### Raw Data
There is no raw data in this repository. Therefore, to recreate the figures from scratch, it is necessary to download the datasets first:

- The RACMO2.3p3 datasets (van Dalum et al., 2021) are available online at: <https://doi.org/10.5281/zenodo.7639053>.
- Ice shelves are defined according to the MEaSURES Antarctic Boundaries dataset, Version 2 (Mouginot et al., 2017), which is available online at: <https://doi.org/10.5067/AXE4121732AD>.
- The Marshall 2003 SAM index is available online from the British Antarctic Survey (BAS) at: <http://www.nerc-bas.ac.uk/public/icd/gjma/newsam.1957.2007.txt>.
- The NOAA SAM index is available online from the NOAA Climate Prediction Centre (CPC) at: <https://www.cpc.ncep.noaa.gov/products/precip/CWlink/daily_ao_index/aao/aao.shtml>.
- The NOAA ENSO3.4 index used in Figure 2a is available online from the Physical Science Laboratory (PSL) at: <https://psl.noaa.gov/gcos_wgsp/Timeseries/Data/nino34.long.anom.data>.
- The ERA5 reanalysis data (Hersbach et al., 2020) used in Figure S2f is available online from the Copernicus Climate Change Service (C3S) Climate Data Store (CDS) at: <https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels-monthly-means>.
- The AMSR melt observations (Picard, 2022) used in Figure 1 are available online at: <https://doi.org/10.18709/PERSCIDO.2022.09.DS376>.

You can also read more about using the RACMO and MEaSURES datasets in my [polarcm](https://github.com/polarSaunderson/polarcm) package. 
In particular, the documentation for the `configure_polarcm()` function explains the necessary set-up for using these datasets.

### Repository Structure & File Names
Most of this repository is written as [Quarto](https://quarto.org) notebooks (i.e. as `.qmd` files).
These notebooks contain a brief introduction to the notebook, a _params_ section to define any parameters that can be modified for the plots, and then the R code itself, which is separated into a series of "chunks" that should be run in order.

There are two main "types" of notebook in this repository: __dt__ and __an__.

The __dt__ notebooks are necessary for processing and wrangling __data__, and are saved in the `Data/` directory.
The __dt__ notebooks are numbered, and it makes the most sense to run them in order (i.e. _dt01_, then _dt02_, and so on).
However, running all 7 __dt__ notebooks is not always strictly necessary if you only want to recreate certain figures; it *should* say at the start of a notebook which other notebooks are prerequisites.
Note as well, that some of these can be quite slow (particularly _dt01_).

The __an__ notebooks are necessary for recreating and __analysing__ the figures, and are saved in the `Analysis/` directory.
The __an__ notebooks are also numbered.
However, the numbering is to ease cross-referencing becasuse the __an__ notebooks are independent of each other and it makes no difference what order they are run in (so long as the necessary __dt__ notebooks have already created the data required).

There are also a number of of local custom R functions; these should be automatically loaded in by the __su__ (_set-up_) file "R/su01_set_up.R" and need no additional preparation.

**WARNING**: Do not trust the custom R functions beyond the constraints of their use in this project (i.e. do not expect them to work except exactly how I have used them).
In particular, the `prep_racmo_names()` function is prone to mistakes and unexpected behaviour.

## Necessary Personal Packages
This repository contains code that relies on 5 personal packages that are currently under development but are available on my [GitHub](https://github.com/polarSaunderson?tab=repositories) page.
These 5 packages (and the version used in this project) are:

  - [domR](https://github.com/polarSaunderson/domR)            (v0.1.5)     functions for easing how I approach a project with R
  - [kulaR](https://github.com/polarSaunderson/kulaR)          (v0.1.5)     a wrapper around [khroma](https://packages.tesselle.org/khroma/) to ease colour management in plots
  - [figuR](https://github.com/polarSaunderson/figuR)          (v0.1.2)     for easily customisable figures
  - [terrapin](https://github.com/polarSaunderson/terrapin)    (v0.1.1)     spinoff from [terra](https://rspatial.github.io/terra/index.html) that eases date handling for spatial data
  - [polarcm](https://github.com/polarSaunderson/polarcm)      (v0.1.3)     eases use of output from the polar regional climate models RACMO and MAR

These should be automatically installed by __renv__. However, they can also be installed like so:

```R
remotes::install_github("polarSaunderson/polarcm")
````

## References
Hersbach, H, B Bell, P Berrisford, S Hirahara, A Horányi, J Muñoz-Sabater, J Nicolas, C Peubey, R Radu, D Schepers, A Simmons, C Soci, S Abdalla, X Abellan, G Balsamo, P Bechtold, G Biavati, J Bidlot, M Bonavita, G De Chiara, P Dahlgren, D Dee, M Diamantakis, R Dragani, J Flemming, R Forbes, M Fuentes, A Geer, L Haimberger, S Healy, RJ Hogan, E Hólm, M Janisková, S Keeley, P Laloyaux, P Lopez, C Lupu, G Radnoti, P de Rosnay, I Rozum, F Vamborg, S Villaume & J-N Thépaut (2020) The ERA5 global reanalysis. Quarterly Journal of the Royal Meteorological Society, 146(730):1999–2049; https://doi.org/10.1002/qj.3803.

Marshall, GJ (2003) Trends in the Southern Annular Mode from Observations and Reanalyses. Journal of Climate, 16(24):4134–4143; `https://doi.org/10.1175/1520-0442(2003)016<4134:TITSAM>2.0.CO;2`

Mouginot, J, B Scheuchl & E Rignot (2017) MEaSURES Antarctic Boundaries for IPY 2007-2009 from Satellite Radar, Version 2. https://doi.org/10.5067/AXE4121732AD.

Picard, G (2022) Snow status (wet/dry) in Antarctica from SMMR, SSM/I, AMSR-E and AMSR2 passive microwave radiometers. https://doi.org/10.18709/PERSCIDO.2022.09.DS376.

van Dalum, C, WJ van de Berg & M van den Broeke (2021) RACMO2.3p3 monthly SMB, SEB and t2m data for Antarctica (1979-2018). https://doi.org/10.5281/ZENODO.7639053.

