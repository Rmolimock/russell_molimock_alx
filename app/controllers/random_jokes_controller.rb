class RandomJokesController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
      @random_dad_joke = fetch_random_dad_joke
      @random_chuck_joke = fetch_random_chuck_joke
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
  
    def fetch_random_chuck_joke
      begin
        uri = URI('https://api.chucknorris.io/jokes/random')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        headers = {'Accept' => 'application/json'}
      
        request = Net::HTTP::Get.new(uri, headers)
        response = http.request(request)
        JSON.parse(response.body)['value']
      rescue
        "Error: When Chuck Norris jokes aren't funny, the API is too afraid to return them."
      end
    end
  end
  