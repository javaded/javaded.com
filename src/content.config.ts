import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

const posts = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/posts" }),
  schema: z.object({
    title: z.string(),
    excerpt: z.string().optional(),
    pubDate: z.coerce.date(),
    readingTime: z.number().int().positive().optional(),
    draft: z.boolean().default(false),
  }),
});

const projects = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/projects" }),
  schema: z.object({
    title: z.string(),
    tagline: z.string().optional(),
    status: z.enum(["live", "building", "archived"]).default("live"),
    url: z.string().url().optional(),
    icon: z.string().default("widgets"),
    order: z.number().default(99),
  }),
});

export const collections = { posts, projects };
