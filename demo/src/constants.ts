export const WIDTH: number = 300;
export const HEIGHT: number = WIDTH;
export const RADIUS: number = 3;

// https://github.com/uwdata/fast-kde#2d-density-estimation
// 256 * 256 = 65536
// https://github.com/LKremer/ggpointdensity/blob/a202ac73d1e18facb57acab8ea0a9b00680518d4/R/geom_pointdensity.R#L138
// https://rdrr.io/cran/MASS/man/kde2d.html
// https://d3js.org/d3-array/sort
// https://stackoverflow.com/questions/43359623/javascripts-equivalent-of-rs-findinterval-or-pythons-bisect-bisect-left
// https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/findInterval
// https://d3js.org/d3-array/bisect#bisect
// https://docs.python.org/3/library/bisect.html#bisect.bisect
// https://observablehq.com/@uwdata/fast-kde#cell-61
export const BINS: [number, number] = [100, 100];
// export const BINS = [25, 25];
// export const BINS = [5, 5];
// export const BINS = [2, 2];

export const PAD: number = 0;
