require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home renders the hero and recent posts" do
    get root_path
    assert_response :success
    assert_select "h1", text: /I’m Javad\. I build software/
  end

  test "about renders the about copy" do
    get about_path
    assert_response :success
    assert_select "h1", text: /I’m Javad\. I build software/
  end

  test "contact renders the contact form" do
    get contact_path
    assert_response :success
    assert_select "form"
    assert_select "input[type=email]"
  end
end
