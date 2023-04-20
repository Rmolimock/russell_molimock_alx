require 'test_helper'

class RandomJokesControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  
  def setup
    get random_url
  end

  test "home page response is ok" do
    assert_response :success
  end

  test "dad joke response is ok" do
    # tests handle both good and bad responses from the various joke APIs.
    begin
      assert_not_nil assigns(:random_dad_joke)
    rescue
      assert_equal assigns(:random_dad_joke), "Error: Sometimes a Dad joke is so bad, even the API refuses to serve them."
    end
  end

  test "chuck norris joke response is ok" do
    begin
      assert_not_nil assigns(:random_chuck_joke)
    rescue
      assert_equal assigns(:random_chuck_joke), "Error: When Chuck Norris jokes aren't funny, the API is too afraid to return them."
    end
  end

  test "jokeAPI response is ok" do
    begin
      assert_not_nil assigns(:random_jokeapi_joke)
    rescue
      assert_equal assigns(:random_jokeapi_joke), "Error: JokeAPI didn't return 200. It must be kidding."
    end
  end
end
