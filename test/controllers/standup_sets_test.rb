require 'test_helper'

class StandupSetsControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  
  test "create a new standup set with a name" do
    headers = { 'Accept' => 'application/json' }
    post standup_sets_path, params: { standup_set: { name: 'Test Set' } }, headers: headers
    assert_response :created
    assert_equal 'application/json', @response.media_type
  end
    
  test "can't create a new standup set without a name" do
    headers = { 'Accept' => 'application/json' }
    post standup_sets_path, params: { standup_set: { name: '' } }, headers: headers
    assert_response :unprocessable_entity
    assert_equal 'application/json', @response.media_type
  end

  test "delete a standup set by id" do
    standup_set = StandupSet.create(name: 'Test Set')
    
    delete standup_set_path(standup_set.id), headers: { 'Accept' => 'application/json' }
    
    assert_nil StandupSet.find_by(id: standup_set.id)
    assert_response :no_content
  end

  test "can't delete a standup set with invalid id" do
    standup_set = StandupSet.create(name: 'Test Set')
    
    delete standup_set_path('invalid id'), headers: { 'Accept' => 'application/json' }
    
    assert_response :not_found
  end

  test "assign a joke to a standup set" do
    joke = Joke.create(content: 'Why did the chicken cross the road?', source: 'JokeAPI')
    standup_set = StandupSet.create(name: 'Test Set')
  
    post add_joke_standup_set_path(standup_set.id, joke_id: joke.id), headers: { 'Accept' => 'application/json' }
  
    standup_set.reload
    joke.reload
    
    assert_equal 1, standup_set.jokes.count
    assert_response :ok
  end
  
  def teardown
    StandupSet.destroy_all
    Joke.destroy_all
  end

  test "remove a joke from a standup set" do
    joke = Joke.create(content: 'Why did the chicken cross the road?', source: 'JokeAPI')
    standup_set = StandupSet.create(name: 'Test Set 2')
    standup_set.jokes << joke
  
    delete remove_joke_standup_set_path(standup_set.id, joke_id: joke.id), headers: { 'Accept' => 'application/json' }
  
    standup_set.reload
    joke.reload
    
    assert_equal 0, standup_set.jokes.count
    assert_response :ok
  end

  test "get one standup set by id" do
    standup_set = StandupSet.create(name: 'Test Set')
    
    get standup_set_path(standup_set.id), headers: { 'Accept' => 'application/json' }
    
    assert_response :ok
    assert_equal 'application/json', @response.media_type
  end

  test " can't get one with invalid id" do
    standup_set = StandupSet.create(name: 'Test Set')
    
    get standup_set_path('invalid id'), headers: { 'Accept' => 'application/json' }
    
    assert_response :not_found
  end
  
end
