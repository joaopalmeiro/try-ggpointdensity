<script setup lang="ts">
// https://github.com/LKremer/ggpointdensity#readme
// https://observablehq.com/@d3/scatterplot-with-shapes
// https://observablehq.com/@observablehq/d3-scatterplot
// https://vueschool.io/articles/vuejs-tutorials/tips-and-gotchas-for-using-key-with-v-for-in-vue-js-3/

import { extent } from "d3-array";
import { scaleLinear } from "d3-scale";
import { density2d } from "fast-kde";

import data from "./data_100.json";

type Datum = (typeof data)[number];

const WIDTH = 300;
const HEIGHT = WIDTH;
const RADIUS = 3;

const xAccessor = (d: Datum) => d.x;
const yAccessor = (d: Datum) => d.y;

const [xMin = 0, xMax = 0] = extent(data, xAccessor);
const [yMin = 0, yMax = 0] = extent(data, yAccessor);

const xScale = scaleLinear().domain([xMin, xMax]).range([0, WIDTH]).nice();
const yScale = scaleLinear().domain([yMin, yMax]).range([HEIGHT, 0]).nice();

// https://github.com/uwdata/fast-kde#2d-density-estimation
// 256 * 256 = 65536
// https://github.com/LKremer/ggpointdensity/blob/a202ac73d1e18facb57acab8ea0a9b00680518d4/R/geom_pointdensity.R#L138
// https://rdrr.io/cran/MASS/man/kde2d.html
// https://d3js.org/d3-array/bisect
// https://stackoverflow.com/questions/43359623/javascripts-equivalent-of-rs-findinterval-or-pythons-bisect-bisect-left
// https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/findInterval
// https://observablehq.com/@uwdata/fast-kde#cell-61

// const bins = [100, 100]
const bins = [25, 25]
// const bins = [2, 2];

const density = density2d(data, { x: xAccessor, y: yAccessor, bins });
const densityPoints = [...density];

// console.log(data);
console.log(densityPoints);
// console.log(density.grid());
</script>

<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    :viewBox="`0 0 ${WIDTH} ${HEIGHT}`"
    :width="`${WIDTH}px`"
    :height="`${HEIGHT}px`"
  >
    <g>
      <circle
        v-for="datum in data"
        :key="JSON.stringify(datum)"
        :cx="xScale(xAccessor(datum))"
        :cy="yScale(yAccessor(datum))"
        :r="RADIUS"
      />
    </g>
  </svg>
</template>
