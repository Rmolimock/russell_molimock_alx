class RandomJokesController < ApplicationController
    require 'net/http'
    require 'json'

  
    def index
      @random_dad_joke = JokeFetcher.fetch_random_dad_joke
      @random_jokeapi_joke = JokeFetcher.fetch_random_jokeapi_joke
      @random_official_joke = JokeFetcher.fetch_random_official_joke
      @random_geek_joke = JokeFetcher.fetch_random_geek_joke

      respond_to do |format|
        format.html
        format.json do
          render json: {
            random_dad_joke: @random_dad_joke,
            random_jokeapi_joke: @random_jokeapi_joke,
            random_official_joke: @random_official_joke,
            random_geek_joke: @random_geek_joke
          }
        end
      end
    end

    def new_dad_joke
      render json: { joke: JokeFetcher.fetch_random_dad_joke }
    end
  
    def new_official_joke
      render json: { joke: JokeFetcher.fetch_random_official_joke }
    end
  
    def new_jokeapi_joke
      render json: { joke: JokeFetcher.fetch_random_jokeapi_joke }
    end
  
    def new_geek_joke
      render json: { joke: JokeFetcher.fetch_random_geek_joke }
    end

  end

  