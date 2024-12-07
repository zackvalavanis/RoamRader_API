class CitiesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  require 'httparty'

  def index
    @cities = City.all
    render :index
  end 

  def show
    @city = City.find_by(id: params[:id])
    
    if @city
      # Construct the full photo URL if photo_reference exists
      if @city.photo_url
        @city.photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{@city.photo_url}&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
      end
      render :show
    else
      render json: { error: 'City not found' }, status: :not_found
    end
  end

  def create
    city_name = params[:city_name]
    
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
      query: {
        query: "city #{city_name}, USA",
        key: ENV['GOOGLE_PLACES_API_KEY']
      }
    })
    
    data = response.parsed_response
    
    if response.code == 200 && data['results'].any?
      new_city_data = data['results'].first
  
      @city = City.find_or_create_by(
        name: new_city_data['name'],
        location: new_city_data['formatted_address'],
        geometry: new_city_data['geometry'].to_json, # Save geometry as JSON
        user_id: current_user.id
      )
  
      # Optional: Save photo reference if available
      photo_url = new_city_data['photos']&.first['photo_reference']
      @city.update(photo_url: photo_url) if photo_url
  
      if @city.persisted?
        render json: @city, status: :created
      else
        render json: { error: 'Failed to save city data' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Failed to fetch data from the API' }, status: :unprocessable_entity
    end
  end  

  def destroy
    @city = City.find_by(id: params[:id])
    if @city.nil? 
      return render json: { error: 'City not found' }, status: :not_found
    end
    @city.comments.destroy_all

    if @city.destroy
      render json: { message: 'The city has been deleted' }, status: :ok
    else 
      render json: { error: 'The city could not be deleted' }, status: :bad_request
    end
  end
end
