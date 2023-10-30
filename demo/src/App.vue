<script setup lang="ts">
// https://github.com/LKremer/ggpointdensity#readme
// https://observablehq.com/@d3/scatterplot-with-shapes
// https://observablehq.com/@observablehq/d3-scatterplot
// https://vueschool.io/articles/vuejs-tutorials/tips-and-gotchas-for-using-key-with-v-for-in-vue-js-3/

import { extent } from "d3-array";
import { scaleLinear } from "d3-scale";

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

// console.log(data);
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
