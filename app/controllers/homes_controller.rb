class HomesController < ApplicationController
  require 'httparty'

  def index
    
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
      query: {
        query: "city Paris",
        key: ENV['GOOGLE_PLACES_API_KEY']
      }
    })
    data = response.parsed_response

    render json: { message: 'HomePage', api_response: data }
  end
end
