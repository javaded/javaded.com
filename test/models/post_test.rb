require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "to_param returns the slug" do
    assert_equal "the-art-of-simplicity-in-design", posts(:simplicity).to_param
  end

  test "newest_first orders by published_at descending" do
    assert_equal [ posts(:simplicity).slug, posts(:lessons).slug, posts(:draft).slug ],
      Post.newest_first.pluck(:slug)
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
