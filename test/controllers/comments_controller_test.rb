require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get comments_show_url
    assert_response :success
  end

  test "should get destroy" do
    get comments_destroy_url
    assert_response :success
  end
end
