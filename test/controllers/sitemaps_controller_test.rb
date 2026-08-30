require "test_helper"

class SitemapsControllerTest < ActionDispatch::IntegrationTest
  test "renders an xml sitemap with public pages" do
    get sitemap_url
    assert_response :success
    assert_equal "application/xml", @response.media_type

    assert_match "<loc>#{root_url}</loc>", @response.body
    assert_match "<loc>#{about_url}</loc>", @response.body
    assert_match "<loc>#{posts_url}</loc>", @response.body
    assert_match "<loc>#{projects_url}</loc>", @response.body
  end

  test "includes published posts with lastmod" do
    get sitemap_url

    assert_match "<loc>#{post_url(posts(:simplicity))}</loc>", @response.body
    assert_match "<lastmod>#{posts(:simplicity).published_at.iso8601}</lastmod>", @response.body
  end

  test "excludes unpublished posts" do
    get sitemap_url

    assert_no_match "unpublished-draft", @response.body
  end

  test "includes projects" do
    get sitemap_url

    Project.find_each do |project|
      assert_match "<loc>#{project_url(project)}</loc>", @response.body
    end
  end
end
