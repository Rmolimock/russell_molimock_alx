require 'test_helper'

class JokesControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  
  def setup
    @joke_params = { content: 'Why did the chicken cross the road?', source: 'Unknown' }
  end
  
  test "create joke" do
    assert_difference 'Joke.count', 1 do
      post jokes_path, params: { joke: @joke_params }
    end
    
    joke = Joke.last
    assert_equal @joke_params[:content], joke.content
    assert_equal @joke_params[:source], joke.source
    
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_match /Joke created successfully/, flash[:notice]
  end
  
  teardown do
    Joke.destroy_all
  end
end
