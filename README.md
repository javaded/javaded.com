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

## Newsletter & contact form (Resend)

GitHub Pages only serves static files, so the Resend API key can never live in
this repo or in the built site's JavaScript (anyone could steal it and send
email as you). Instead, a tiny Cloudflare Worker (`worker/`) holds the key as a
secret and forwards requests to Resend:

- `POST /subscribe` → adds the email to a Resend **Audience** (newsletter)
- `POST /contact` → sends the message via Resend to `j.effatdoost@gmail.com`

### One-time setup

1. **Resend**: create an Audience (Contacts → Audiences) and copy its ID.
2. **Resend**: create an API key with **Full access** — sending-only keys can't
   touch Audiences/Contacts, which the newsletter signup needs.
3. **Cloudflare**: create a Worker (free tier is plenty), paste
   `worker/index.js` into the quick editor — or deploy with:
   `npx wrangler deploy` from the `worker/` directory.
4. **Worker secrets/settings** (dashboard → Settings → Variables, or
   `npx wrangler secret put NAME`):
   - `RESEND_API_KEY` (secret) — your Resend API key
   - `RESEND_AUDIENCE_ID` (secret) — the Audience ID from step 1
   - `CONTACT_TO` — `j.effatdoost@gmail.com` (already in `wrangler.toml`)
   - `CONTACT_FROM` — `onboarding@resend.dev`, or your own address once you
     verify a domain in Resend
5. Copy the Worker's URL (e.g. `https://javaded-api.your-subdomain.workers.dev`)
   into `.env` as `PUBLIC_API_URL=...` and add the same variable as a
   repository secret in GitHub (Settings → Secrets and variables → Actions →
   Variables) so production builds get it too. The deploy workflow passes it
   to `npm run build` automatically via the Actions `env`.

The Worker URL is public in the client code — that's fine, it only accepts the
two JSON endpoints and has a honeypot against bots.

> Note: without a verified domain, Resend only lets `onboarding@resend.dev`
> send to your own account's email address — fine here, since the contact form
> only delivers to your Gmail.

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
