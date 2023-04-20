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
  end

  test "delete joke by id" do
    joke = Joke.create(@joke_params)
    
    delete joke_path(joke.id), headers: { 'Accept' => 'application/json' }
    
    assert_nil Joke.find_by(id: joke.id)
    assert_response :no_content
  end

  test "can't delete joke with invalid id" do
    joke = Joke.create(@joke_params)
    
    delete joke_path('invalid id'), headers: { 'Accept' => 'application/json' }
    
    assert_response :not_found
  end
  
  

  test "delete all jokes" do
    Joke.create(@joke_params)
    Joke.create(@joke_params)
    
    delete jokes_path
    
    assert_equal 0, Joke.count
    assert_redirected_to jokes_path
    follow_redirect!
  end

  teardown do
    Joke.delete_all
  end
end
