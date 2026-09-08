# javaded.com

Personal website. Static site built with [Astro](https://astro.build) and Tailwind CSS, deployed to GitHub Pages.

## Writing posts

Create a markdown file in `src/content/posts/`:

```markdown
---
title: My Post
excerpt: Short description shown on the blog index.
pubDate: 2026-09-09
readingTime: 3
draft: true
---

Body text here.
```

- The filename becomes the URL: `src/content/posts/my-post.md` → `/posts/my-post`
- `draft: true` hides a post from production builds
- `readingTime` is optional; it is calculated from word count when omitted
- Commit and push to `master` — GitHub Actions builds and deploys automatically

## Projects

Project entries live in `src/content/projects/*.md`.

## Development

```sh
npm install
npm run dev
```

## Build

```sh
npm run build
npm run preview
```
