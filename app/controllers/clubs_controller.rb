require 'net/http'
require 'uri'
require 'json'

class ClubsController < ApplicationController
  YELP_API_BUSINESS_SEARCH = "https://api.yelp.com/v3/businesses/search"

  def index
    @clubs = comedy_clubs_by_zip(params[:zip_code])
  
    respond_to do |format|
      format.html
      format.json { render json: @clubs }
    end
  end

  private

  def comedy_clubs_by_zip(zip_code)
    uri = URI(YELP_API_BUSINESS_SEARCH)
    uri.query = URI.encode_www_form({
      term: "comedy club",
      location: zip_code,
      sort_by: "best_match"
    })

    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    if res.is_a?(Net::HTTPSuccess) && res.body.present? && JSON.parse(res.body)['businesses'].present?
        JSON.parse(res.body)['businesses']
    else
      []
    end
  end
end
