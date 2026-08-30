xml.instruct!
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc root_url
  end

  xml.url do
    xml.loc about_url
  end

  xml.url do
    xml.loc contact_url
  end

  xml.url do
    xml.loc posts_url
  end

  xml.url do
    xml.loc projects_url
  end

  @posts.each do |post|
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.published_at.iso8601
    end
  end

  @projects.each do |project|
    xml.url do
      xml.loc project_url(project)
      xml.lastmod project.updated_at.iso8601
    end
  end
end
