class RandomJokesController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
      @random_dad_joke = fetch_random_dad_joke
      @random_jokeapi_joke = fetch_random_jokeapi_joke
      @random_official_joke = fetch_random_official_joke
      @random_geek_joke = fetch_random_geek_joke
    end

    def new_dad_joke
      render json: { joke: fetch_random_dad_joke }
    end

    def new_official_joke
      render json: { joke: fetch_random_official_joke }
    end

    def new_jokeapi_joke
        render json: { joke: fetch_random_jokeapi_joke }
    end
  
    def new_geek_joke
        render json: { joke: fetch_random_geek_joke }
    end

    private

    def create_request(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        headers = {'Accept' => 'application/json'}

        request = Net::HTTP::Get.new(uri, headers)
        response = http.request(request)
        response
    end
  
    def fetch_random_dad_joke
      begin
        uri = URI('https://icanhazdadjoke.com/')
        response = create_request(uri)
        JSON.parse(response.body)['joke']
      rescue
        "Error: Sometimes a Dad joke is so bad, even the API refuses to serve them."
      end
    end        

    def fetch_random_official_joke
        begin
            uri = URI('https://official-joke-api.appspot.com/random_joke')
            response = create_request(uri)
            setup = JSON.parse(response.body)['setup']
            delivery = JSON.parse(response.body)['punchline']
            "#{setup} #{delivery}"
        rescue
            "Error: The Official Joke API is officially a joke. It returned a bad response, sorry!."
        end
    end

    def fetch_random_jokeapi_joke
        begin
          uri = URI('https://v2.jokeapi.dev/joke/Any?safe-mode')
          response = create_request(uri)

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

      def fetch_random_geek_joke
        begin
          uri = URI('https://geek-jokes.sameerkumar.website/api?format=json')
          response = create_request(uri)

          JSON.parse(response.body)['joke']
        rescue
          "Error: The geeks at geek-jokes messed up. Bad response."
        end
      end

  end

  