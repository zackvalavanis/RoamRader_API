class CitiesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  require 'httparty'

  def index 
    @cities = City.where(user_id: current_user.id)
    render :index
  end 

  def show
    city_name = params[:id]  
    @city = City.find_by(name: city_name)

    unless @city
      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
        query: {
          query: "city #{city_name}",
          key: ENV['GOOGLE_PLACES_API_KEY']
        }
      })
      data = response.parsed_response

      if response.code == 200 && data['results'].any?
        new_city_data = data['results'].first
        @city = City.create(
          name: new_city_data['name'],
          location: new_city_data['formatted_address'],
          user_id: current_user.id
        )
      else
        render json: { error: 'Failed to fetch data from the API' }, status: :unprocessable_entity
        return
      end
    end

    @comments = @city.comments
    render json: { city: @city, comments: @comments }
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

    if response.code == 200 && data['results'].any?
      new_city_data = data['results'].first

      @city = City.find_or_create_by(
        name: new_city_data['name'],
        location: new_city_data['formatted_address'],
        user_id: current_user.id
      )

      render json: @city, status: :created
    else
      render json: { error: 'Failed to fetch data from the API' }, status: :unprocessable_entity
    end
  end
  
end
