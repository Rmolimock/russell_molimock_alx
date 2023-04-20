require 'test_helper'

class JokesControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  
  def setup
    @joke_params = { content: 'Why did the chicken cross the road?', source: 'JokeAPI' }
    @bad_joke_params = { content: '', source: '' }
  end

  test "create joke and get json response" do
    post jokes_path, params: { joke: @joke_params }, headers: { 'Accept' => 'application/json' }
    assert_response :created
    assert_equal 'application/json', @response.media_type
  end
  
  test "create joke and get html response" do
    post jokes_path, params: { joke: @joke_params }
    assert_response :redirect
    assert_equal 'text/html', @response.media_type
  end
  
  test "can't create joke with invalid params, get json response" do
    post jokes_path, params: { joke: @bad_joke_params }, headers: { 'Accept' => 'application/json' }
    assert_response :unprocessable_entity
    assert_equal 'application/json', @response.media_type
  end
  
  test "can't create joke with invalid params, get html response" do
    post jokes_path, params: { joke: @bad_joke_params }
    assert_response :unprocessable_entity
    assert_equal 'text/html', @response.media_type
    assert_equal "Invalid joke parameters", flash[:alert]
  end

  test "delete all jokes" do
    Joke.create(content: "Joke 1", source: "Source 1")
    Joke.create(content: "Joke 2", source: "Source 2")
    
    delete jokes_path
    
    assert_equal 0, Joke.count
    assert_redirected_to jokes_path
    follow_redirect!
    assert_match /All jokes deleted successfully/, flash[:notice]
  end

  teardown do
    Joke.delete_all
  end
end
