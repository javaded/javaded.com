require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "to_param returns the slug" do
    assert_equal "the-art-of-simplicity-in-design", posts(:simplicity).to_param
  end

  test "newest_first orders by published_at descending" do
    ordered = Post.newest_first.to_a
    assert ordered.first.published_at > ordered.last.published_at
  end

  test "paragraphs splits the body on blank lines" do
    paragraphs = posts(:simplicity).paragraphs
    assert_equal 3, paragraphs.length
  end

  test "published? is true when published_at is in the past" do
    assert posts(:simplicity).published?
    assert_not posts(:draft).published?
  end

  test "creating a post with a title but no slug generates one" do
    post = Post.create!(title: "A Fresh Title", body: "x")
    assert_equal "a-fresh-title", post.slug
  end
end
