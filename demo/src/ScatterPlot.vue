<script setup lang="ts">
import { bisectRight, extent } from "d3-array";
import type { ScaleSequential } from "d3-scale";
import { scaleLinear, scaleSequential } from "d3-scale";
import { interpolateViridis } from "d3-scale-chromatic";
import { density2d } from "fast-kde";
import { ref } from "vue";

import { BINS, HEIGHT, PAD, RADIUS, WIDTH } from "./constants";
import ContinuousColorLegend from "./ContinuousColorLegend.vue";
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

// https://vuejs.org/guide/essentials/reactivity-fundamentals.html#script-setup
const valueToHighlight = ref<number>();

const xAccessor: Accessor = (d) => d.x;
const yAccessor: Accessor = (d) => d.y;
const zAccessor: Accessor<DensityDatum> = (d) => d.z;

const [xMin = 0, xMax = 0] = extent(data, xAccessor);
const [yMin = 0, yMax = 0] = extent(data, yAccessor);

const xScale = scaleLinear().domain([xMin, xMax]).range([0, WIDTH]).nice();
const yScale = scaleLinear().domain([yMin, yMax]).range([HEIGHT, 0]).nice();

const density = density2d(data, {
  x: xAccessor,
  y: yAccessor,
  bins: BINS,
  pad: PAD,
});
const densityPoints: DensityDatum[] = [...density];

// https://d3js.org/d3-scale/sequential
// https://github.com/d3/d3-scale/blob/v4.0.2/src/linear.js#L20
const [zMin = 0, zMax = 0] = extent(densityPoints, zAccessor);
// const colorDomain = [zMin, zMax];
const colorDomain = [zMax, zMin];
// import { nice } from "d3-array";
// const colorDomain = nice(zMin, zMax, 10);
const colorScale: ScaleSequential<string> = scaleSequential(
  colorDomain,
  interpolateViridis,
);
// console.log([zMin, zMax], colorDomain);

const xDensity: number[] = [...new Set(densityPoints.map(xAccessor))];
const yDensity: number[] = [...new Set(densityPoints.map(yAccessor))];

const dataToPlot: DensityDatum[] = data.map((d: DataDatum) => ({
  ...d,
  z: getDensity(
    xAccessor(d),
    yAccessor(d),
    densityPoints,
    xDensity,
    yDensity,
    zAccessor,
  ),
}));
// console.log(dataToPlot);

const setValueToHighlight = (newValue?: number): void => {
  valueToHighlight.value = newValue;
};
</script>

<template>
  <div :style="{ display: 'flex', 'flex-direction': 'column', gap: '1rem' }">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      :viewBox="`0 0 ${WIDTH} ${HEIGHT}`"
      :width="`${WIDTH}px`"
      :height="`${HEIGHT}px`"
    >
      <g>
        <circle
          v-for="datum in dataToPlot"
          :key="JSON.stringify(datum)"
          :cx="xScale(xAccessor(datum))"
          :cy="yScale(yAccessor(datum))"
          :r="`${RADIUS}px`"
          :fill="colorScale(zAccessor(datum))"
          stroke="white"
          stroke-width="0.5px"
          paint-order="stroke"
          @mouseenter="setValueToHighlight(zAccessor(datum))"
          @mouseleave="setValueToHighlight(undefined)"
        />
      </g>
    </svg>

    <ContinuousColorLegend
      :colorScale="colorScale"
      :valueToHighlight="valueToHighlight"
    />
  </div>
</template>
