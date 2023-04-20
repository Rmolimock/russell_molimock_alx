class RandomJokesController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
      @random_dad_joke = fetch_random_dad_joke
      @random_jokeapi_joke = fetch_random_jokeapi_joke
    end

    def new_dad_joke
      render json: { joke: fetch_random_dad_joke }
    end

    def new_jokeapi_joke
        render json: { joke: fetch_random_jokeapi_joke }
    end
  
    private
  
    def fetch_random_dad_joke
      begin
        uri = URI('https://icanhazdadjoke.com/')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        headers = {'Accept' => 'application/json'}
      
        request = Net::HTTP::Get.new(uri, headers)
        response = http.request(request)
        JSON.parse(response.body)['joke']
      rescue
        "Error: Sometimes a Dad joke is so bad, even the API refuses to serve them."
      end
    end

    def fetch_random_jokeapi_joke
        begin
          uri = URI('https://v2.jokeapi.dev/joke/Any?safe-mode')
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          headers = {'Accept' => 'application/json'}
        
          request = Net::HTTP::Get.new(uri, headers)
          response = http.request(request)
          setup = JSON.parse(response.body)['setup']
          delivery = JSON.parse(response.body)['delivery']
          if setup.nil?
            JSON.parse(response.body)['joke']
          else
            "#{setup} #{delivery}"
          end
        rescue
          "Error: JokeAPI didn't return 200. It must be kidding."
        end
      end
  end
  