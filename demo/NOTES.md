# Notes

- https://www.totaltypescript.com/type-vs-interface-which-should-you-use
- https://github.com/vasturiano/kapsule
- https://github.com/vasturiano/svg-text-fit
- https://github.com/vasturiano/svg-utils
- https://www.visualcinnamon.com/2016/05/smooth-color-legend-d3-svg-gradient/
- https://github.com/LKremer/ggpointdensity#readme
- https://observablehq.com/@d3/scatterplot-with-shapes
- https://observablehq.com/@observablehq/d3-scatterplot
- https://vueschool.io/articles/vuejs-tutorials/tips-and-gotchas-for-using-key-with-v-for-in-vue-js-3/

## Commands

```bash
npm install vue && npm install -D vite @vitejs/plugin-vue typescript vue-tsc create-vite-tsconfigs sort-package-json npm-run-all2 prettier
```

```bash
npm install fast-kde
```

```bash
npm install d3-array d3-scale d3-scale-chromatic d3-format && npm install -D @types/d3-array @types/d3-scale @types/d3-scale-chromatic @types/d3-format
```

## Snippets

```js
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
```
