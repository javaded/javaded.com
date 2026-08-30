require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "index lists featured project first" do
    get projects_path
    assert_response :success
    assert_equal Project.featured_first.pluck(:title), css_select("main h2").map(&:text)
  end

  test "show renders a single project by slug" do
    get project_path(projects(:scoutspin))
    assert_response :success
    assert_select "h1", text: "ScoutSpin"
  end

  test "show 404s for an unknown slug" do
    get "/projects/nope"
    assert_response :not_found
  end
end
