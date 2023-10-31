<script setup lang="ts">
import type { ScaleSequential } from "d3-scale";
import type { PropType } from "vue";
import { computed } from "vue";
import { format } from "d3-format";

import { LEGEND_AXIS_HEIGHT, LEGEND_HEIGHT, LEGEND_WIDTH } from "./constants";

type RampDatum = {
  offset: number;
  stopColor: string;
};
type RampData = RampDatum[];

const formatter = format(".4~f");

const ramp = (interpolator: (t: number) => string, n = 256): RampData => {
  const data: RampData = [];

  for (let i = 0; i < n; ++i) {
    const offset = i / (n - 1);
    const datum: RampDatum = {
      offset,
      stopColor: interpolator(offset),
    };

    data.push(datum);
  }

  return data;
};

// https://vuejs.org/api/sfc-script-setup.html#type-only-props-emit-declarations
// https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/color-interpolation
const props = defineProps({
  colorScale: {
    type: Function as PropType<ScaleSequential<string>>,
    required: true,
  },
});

const HEIGHT = computed<number>(() => {
  return LEGEND_HEIGHT + LEGEND_AXIS_HEIGHT;
});

// https://observablehq.com/@d3/color-legend
// https://github.com/d3/d3/blob/main/docs/components/ColorRamp.vue
// https://github.com/d3/d3/blob/main/docs/d3-scale-chromatic/sequential.md?plain=1#L69
// https://d3js.org/d3-scale-chromatic/sequential#interpolateViridis
// https://developer.mozilla.org/en-US/docs/Web/SVG/Element/stop
// console.log(
//   props.colorScale.domain(),
//   props.colorScale.range(),
//   props.colorScale.interpolator(),
// );
// https://stackoverflow.com/questions/72802146/reverse-the-direction-of-the-color-in-linear-gradient-legend
const isReversed = computed<boolean>(() => {
  const colorDomain = props.colorScale.domain();
  return colorDomain[0] > colorDomain[1];
});

const gradientStart = computed<string>(() => {
  return isReversed.value ? "100%" : "0%";
});
const gradientEnd = computed<string>(() => {
  return isReversed.value ? "0%" : "100%";
});

const startLabel = computed<string>(() => {
  const colorDomain = props.colorScale.domain();
  const value = isReversed.value ? colorDomain[1] : colorDomain[0];

  return formatter(value);
});
const endLabel = computed<string>(() => {
  const colorDomain = props.colorScale.domain();
  const value = isReversed.value ? colorDomain[0] : colorDomain[1];

  return formatter(value);
});

const rampData = computed<RampData>(() => {
  return ramp(props.colorScale.interpolator());
});
// console.log(rampData.value);
</script>

<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    :viewBox="`0 0 ${LEGEND_WIDTH} ${HEIGHT}`"
    :width="`${LEGEND_WIDTH}px`"
    :height="`${HEIGHT}px`"
  >
    <defs>
      <linearGradient
        id="continuousColorLegend"
        :x1="gradientStart"
        :x2="gradientEnd"
        :style="{ 'color-interpolation': 'sRGB' }"
      >
        <stop
          v-for="{ offset, stopColor } in rampData"
          :key="offset"
          :offset="offset"
          :stop-color="stopColor"
        />
      </linearGradient>
    </defs>

    <rect
      :width="`${LEGEND_WIDTH}px`"
      :height="`${LEGEND_HEIGHT}px`"
      fill="url(#continuousColorLegend)"
    />

    <g>
      <text
        dominant-baseline="text-before-edge"
        :y="`${LEGEND_HEIGHT}px`"
        text-anchor="start"
        font-size="12px"
        font-family="Arial"
      >
        {{ startLabel }}
      </text>
      <text
        dominant-baseline="text-before-edge"
        :x="`${LEGEND_WIDTH}px`"
        :y="`${LEGEND_HEIGHT}px`"
        text-anchor="end"
        font-size="12px"
        font-family="Arial"
      >
        {{ endLabel }}
      </text>
    </g>
  </svg>
</template>
