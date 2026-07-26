require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "index lists newest posts first" do
    get posts_path
    assert_response :success
    assert_select "article", count: Post.count
  end

  test "show renders a single post by slug" do
    get post_path(posts(:simplicity))
    assert_response :success
    assert_select "h1", text: "The Art of Simplicity in Design"
  end

  test "show 404s for an unknown slug" do
    get "/posts/nope"
    assert_response :not_found
  end
end
