import { getCollection, type CollectionEntry } from "astro:content";

export function formatDate(date: Date): string {
  return date.toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" });
}

export function readingTime(post: CollectionEntry<"posts">): number {
  if (post.data.readingTime) return post.data.readingTime;
  const words = (post.body ?? "").trim().split(/\s+/).filter(Boolean).length;
  return Math.max(1, Math.round(words / 200));
}

export async function getPublishedPosts(limit?: number): Promise<CollectionEntry<"posts">[]> {
  const now = Date.now();
  const posts = (await getCollection("posts", ({ data }) =>
    import.meta.env.PROD ? !data.draft && data.pubDate.getTime() <= now : true
  )).sort((a, b) => b.data.pubDate.getTime() - a.data.pubDate.getTime());
  return limit ? posts.slice(0, limit) : posts;
}

export async function getOrderedProjects(): Promise<CollectionEntry<"projects">[]> {
  return (await getCollection("projects")).sort(
    (a, b) => a.data.order - b.data.order
  );
}
