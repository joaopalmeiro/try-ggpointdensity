import vue from "@vitejs/plugin-vue";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [vue()],
  server: {
    // https://vitejs.dev/config/server-options.html#server-open
    open: true,
  },
});
