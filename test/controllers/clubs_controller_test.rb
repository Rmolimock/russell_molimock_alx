require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clubs_index_url
    assert_response :success
  end

  def setup
    @valid_search_params = { zip_code: '74103' }
    @invalid_search_params = { zip_code: '00000' }
  end

  test "return a valid JSON response with comedy clubs in or around that zip" do
    get clubs_path, params: @valid_search_params, headers: { 'Accept' => 'application/json' }
    assert_response :success

    assert_equal 'application/json', @response.media_type
    json_response = JSON.parse(response.body)
    
    assert json_response.is_a?(Array)
    assert_not_empty json_response
  end

  test "empty array if no comedy clubs in or around that zip" do
    get clubs_path, params: @invalid_search_params, headers: { 'Accept' => 'application/json' }
    assert_response :success
    
    assert_equal 'application/json', @response.media_type
    json_response = JSON.parse(response.body)

    assert json_response.is_a?(Array)
    assert_empty json_response
  end

  test "return a valid HTML response with comedy clubs in or around that zip" do
    get clubs_path, params: @valid_search_params
    assert_response :success

    assert_equal 'text/html', @response.media_type
  end


end
