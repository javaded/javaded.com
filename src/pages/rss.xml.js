import rss from "@astrojs/rss";
import { getPublishedPosts } from "../lib/content";

export async function GET(context) {
  const posts = await getPublishedPosts();
  return rss({
    title: "JavadED",
    description: "I build software and figure things out along the way.",
    site: context.site,
    items: posts.map((post) => ({
      title: post.data.title,
      description: post.data.excerpt,
      pubDate: post.data.pubDate,
      link: `/posts/${post.id}/`,
    })),
  });
}
