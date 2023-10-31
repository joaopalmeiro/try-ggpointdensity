<script setup lang="ts">
// https://github.com/LKremer/ggpointdensity#readme
// https://observablehq.com/@d3/scatterplot-with-shapes
// https://observablehq.com/@observablehq/d3-scatterplot
// https://vueschool.io/articles/vuejs-tutorials/tips-and-gotchas-for-using-key-with-v-for-in-vue-js-3/

import { bisectRight, extent, nice } from "d3-array";
import { scaleLinear, scaleSequential } from "d3-scale";
import { interpolateViridis } from "d3-scale-chromatic";
import { density2d } from "fast-kde";

// import data from "./data_100.json";
import data from "./data_1000.json";

type DataDatum = (typeof data)[number];
type DensityDatum = DataDatum & {
  z: number;
};
type Datum = DataDatum | DensityDatum;

type Accessor<TDatum extends Datum = DataDatum> = (d: TDatum) => number;

const getDensity = (
  x: number,
  y: number,
  densityPoints: DensityDatum[],
  xDensity: number[],
  yDensity: number[],
  zAccessor: Accessor<DensityDatum>,
): number => {
  const xIndex = bisectRight(xDensity, x) - 1;
  const yIndex = bisectRight(yDensity, y) - 1;

  const densityPointsIndex = yIndex * yDensity.length + xIndex;
  const densityPoint = densityPoints[densityPointsIndex];
  // console.log({ x, y, densityPoint, xIndex, yIndex, densityPointsIndex });
  // console.log(
  //   densityPoints.find(
  //     (d) => d.x === xDensity[xIndex] && d.y === yDensity[yIndex],
  //   ),
  // );

  return zAccessor(densityPoint);
};

const WIDTH: number = 300;
const HEIGHT: number = WIDTH;
const RADIUS: number = 3;

const xAccessor: Accessor = (d) => d.x;
const yAccessor: Accessor = (d) => d.y;
const zAccessor: Accessor<DensityDatum> = (d) => d.z;

const [xMin = 0, xMax = 0] = extent(data, xAccessor);
const [yMin = 0, yMax = 0] = extent(data, yAccessor);

const xScale = scaleLinear().domain([xMin, xMax]).range([0, WIDTH]).nice();
const yScale = scaleLinear().domain([yMin, yMax]).range([HEIGHT, 0]).nice();

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

const bins = [100, 100];
// const bins = [25, 25];
// const bins = [5, 5];
// const bins = [2, 2];

const density = density2d(data, { x: xAccessor, y: yAccessor, bins, pad: 0 });
const densityPoints: DensityDatum[] = [...density];

// https://d3js.org/d3-scale/sequential
// https://github.com/d3/d3-scale/blob/v4.0.2/src/linear.js#L20
const [zMin = 0, zMax = 0] = extent(densityPoints, zAccessor);
// const colorDomain = [zMin, zMax];
const colorDomain = [zMax, zMin];
// const colorDomain = nice(zMin, zMax, 10);
const colorScale = scaleSequential(colorDomain, interpolateViridis);
// console.log([zMin, zMax], colorDomain);

const xDensity: number[] = [...new Set(densityPoints.map(xAccessor))];
const yDensity: number[] = [...new Set(densityPoints.map(yAccessor))];

// console.log(
//   getDensity(
//     xAccessor(data[7]),
//     yAccessor(data[7]),
//     densityPoints,
//     xDensity,
//     yDensity,
//     zAccessor,
//   ),
// );

// https://github.com/uwdata/fast-kde/blob/dca6375c6e3baa67c7b9f15e073def4e7a6bc518/src/density2d.js#L26
// https://github.com/uwdata/fast-kde/blob/dca6375c6e3baa67c7b9f15e073def4e7a6bc518/src/bin2d.js
// const xValue = xAccessor(data[0]);
// const xValue = xAccessor(data[1]);
// const xValue = xAccessor(data[2]);
// const xValue = xDensity[0];
// const xValue = xDensity[xDensity.length - 1];
// console.log({
//   value: xValue,
//   bisectLeft: bisectLeft(xDensity, xValue),
//   bisectCenter: bisectCenter(xDensity, xValue),
//   bisectRight: bisectRight(xDensity, xValue),
// });
// const xDensityFromR = [-2.3456977, -1.1220255, 0.1016467, 1.3253189, 2.5489911];
// console.log({
//   value: xValue,
//   bisectLeft: bisectLeft(xDensityFromR, xValue),
//   bisectCenter: bisectCenter(xDensityFromR, xValue),
//   bisectRight: bisectRight(xDensityFromR, xValue),
// });
// console.log(bisectRight(yDensity, yDensity[yDensity.length - 1]));
// console.log(xDensityFromR);
// console.log(data);
// console.log(densityPoints);
// console.log(xDensity);
// console.log(yDensity);
// console.log(density.grid());
// console.log(density.extent());

// R (w/ MASS::bandwidth.nrd): 1.839297 15.182454
// fast-kde: 0.45982345378511363 3.7956138170092566
// https://github.com/uwdata/fast-kde/blob/01c7eaff9a5901206f8ebe811b8c6a41f9688f7e/src/nrd.js#L3
// https://github.com/uwdata/fast-kde/blob/dca6375c6e3baa67c7b9f15e073def4e7a6bc518/src/density2d.js#L14
// https://github.com/cran/MASS/blob/7.3-60/R/hist.scott.R#L38
// https://github.com/d3/d3-array/blob/v3.2.4/src/threshold/scott.js
// https://en.wikipedia.org/wiki/Histogram (Scott's normal reference rule)
// console.log(
//   nrd(data, xAccessor),
//   nrd(data, yAccessor),
//   nrd(data, xAccessor) * 4,
//   nrd(data, yAccessor) * 4,
// );
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
        :fill="
          colorScale(
            getDensity(
              xAccessor(datum),
              yAccessor(datum),
              densityPoints,
              xDensity,
              yDensity,
              zAccessor,
            ),
          )
        "
        stroke="white"
        stroke-width="0.5px"
        paint-order="stroke"
      />
    </g>
  </svg>
</template>
