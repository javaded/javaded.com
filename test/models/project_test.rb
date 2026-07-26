require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "to_param returns the slug" do
    assert_equal "scoutspin", projects(:scoutspin).to_param
  end

  test "status enum exposes live/building/archived predicates" do
    assert projects(:scoutspin).live?
    assert projects(:buildcue).building?
    assert projects(:archived).archived?
  end

  test "status_badge_classes returns matching array for each status" do
    assert_equal 2, projects(:scoutspin).status_badge_classes.length
    assert_equal 2, projects(:archived).status_badge_classes.length
  end

  test "featured_first puts featured projects on top" do
    ordered = Project.featured_first.to_a
    assert ordered.first.featured?
  end

  test "creating a project with a title but no slug generates one" do
    project = Project.create!(title: "Brand New Thing", description: "x")
    assert_equal "brand-new-thing", project.slug
  end
end
