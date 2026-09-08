import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  site: "https://javaded.com",
  integrations: [sitemap()],
  image: {
    service: { entrypoint: "astro/assets/services/noop" },
  },
  vite: {
    plugins: [tailwindcss()],
  },
});
