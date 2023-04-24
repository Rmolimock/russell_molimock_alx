require "test_helper"

class PerformControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get perform_url
    assert_response :success
  end

end
