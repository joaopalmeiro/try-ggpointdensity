# Notes

- https://stackoverflow.com/questions/25378184/extract-data-from-a-ggplot
- https://ggplot2.tidyverse.org/reference/ggplot_build.html
- https://github.com/IRkernel/IRkernel
- https://astrobiomike.github.io/R/managing-r-and-rstudio-with-conda
- https://github.com/melff/RKernel
- https://www.happykhan.com/posts/conda-install-r/
- https://www.tidyverse.org/packages/
- https://github.com/apwheele/Blog_Code/tree/master/R/conda_env
- https://andrewpwheeler.com/2022/04/08/managing-r-environments-using-conda/
- https://posit.co/download/rstudio-desktop/
- https://formulae.brew.sh/cask/rstudio
- https://support.posit.co/hc/en-us/articles/215733837-Managing-libraries-for-RStudio-Workbench-RStudio-Server
- https://support.posit.co/hc/en-us/articles/219949047-Installing-older-versions-of-packages
- https://github.com/r-lib/pak
- https://github.com/r-lib/rig
- https://github.com/r-lib/rig#installing-rig-on-macos-homebrew-
- https://github.com/r-lib/rig/issues/173
- https://github.com/r-lib/rig/issues/174
- https://brocktibert.com/post/r-dataframe-to-json/
- https://observablehq.com/plot/marks/area#areaY
- https://observablehq.com/plot/interactions/crosshair
- https://github.com/observablehq/plot/blob/v0.6.11/test/plots/crosshair.ts#L25
- https://github.com/observablehq/plot/blob/v0.6.11/src/marks/crosshair.js#L20
- https://github.com/observablehq/plot/blob/v0.6.11/src/interactions/pointer.js
- https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerenter_event
- https://github.com/simple-statistics/simple-statistics
- http://simple-statistics.github.io/docs/
- https://stackoverflow.com/questions/30610675/python-pandas-equivalent-in-javascript

## Commands

```bash
conda deactivate && conda env remove --name try-ggpointdensity
```

```bash
R -e 'IRkernel::installspec()'
```

```bash
npm create vite@latest pointdensity-demo -- --template vue-ts
```

```bash
npm create vue@latest pointdensity-demo
```

## Snippets

```yml
name: try-ggpointdensity
channels:
  - conda-forge
dependencies:
  - r-base=4.3.1
  - r-devtools=2.4.5
```
