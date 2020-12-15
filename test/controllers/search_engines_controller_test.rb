require "test_helper"

class SearchEnginesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get search_engines_search_url
    assert_response :success
  end
end
