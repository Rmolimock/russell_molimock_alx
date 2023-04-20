require 'test_helper'

class RandomJokesControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  
  def setup
    get root_url
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

  test "officialjokeapi joke response is ok" do
    begin
      assert_not_nil assigns(:random_official_joke)
    rescue
      assert_equal assigns(:random_official_joke), "Error: The Official Joke API is officially a joke. It returned a bad response, sorry!."
    end
  end

  test "jokeAPI response is ok" do
    begin
      assert_not_nil assigns(:random_jokeapi_joke)
    rescue
      assert_equal assigns(:random_jokeapi_joke), "Error: JokeAPI didn't return 200. It must be kidding."
    end
  end

  test "geek joke response is ok" do
    begin
      assert_not_nil assigns(:random_geek_joke)
    rescue
      assert_equal assigns(:random_geek_joke), "Error: The geeks at geek-jokes messed up. Bad response."
    end
  end

end

