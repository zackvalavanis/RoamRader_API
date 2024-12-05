class CitiesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  require 'httparty'

  def index 
    @cities = City.all
    render :index
  end 

  def show 
    @city = City.find_by(id: params[:id])
    render :show
  end

  def create
    city_name = params[:city_name]
  
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
      query: {
        query: "city #{city_name}, USA",  # Add the country for more precision
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

  def destroy 
    @city = City.find_by(id: params[:id])
    if @city.nil? 
      return render json: { error: 'City not found'}, status: :not_found
    end
    @city.comments.destroy_all

    if @city.destroy
      render json: {message: 'The city has been deleted'}, status: :ok
    else 
      render json: {error: 'the city could not be deleted'}, status: :bad_request
    end
  end 
  
end
