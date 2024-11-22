class HomesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  
  require 'httparty'

  def index

    city_name = params[:city_name]
    
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
      query: {
        query: "city #{city_name}",
        key: ENV['GOOGLE_PLACES_API_KEY']
      }
    })
    data = response.parsed_response

    render json: { message: 'HomePage', api_response: data }
  end

  def create
      city_name = params[:city_name]
  
      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
        query: {
          query: "city #{city_name}",
          key: ENV['GOOGLE_PLACES_API_KEY']
        }
      })
  
      data = response.parsed_response

    data = response.parsed_response

    if response.code == 200
      render json: { message: "Success", api_response: data }
    else
      render json: { error: data['error_message'] || 'An error occurred' }, status: :unprocessable_entity
    end
  end
end
