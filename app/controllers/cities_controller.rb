class CitiesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  require 'httparty'

  def index
    @cities = City.all
  
    @cities.each do |city|
      city.photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{city.photo_url}&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
    end
  
    render :index
  end
  

  def show
    @city = City.find_by(id: params[:id])
    
    if @city
      @city.geometry = JSON.parse(@city.geometry) if @city.geometry.present?
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
    existing_city = City.find_by(name: city_name)
  
    if existing_city
      render json: { message: 'City already exists', city: existing_city }, status: :unprocessable_entity
      return
    end
  
    # Fetch data from Google Places API
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", {
      query: {
        query: "city #{city_name}, USA",
        key: ENV['GOOGLE_PLACES_API_KEY']
      }
    })
  
    data = response.parsed_response
  
    if response.code == 200 && data['results'].present?
      new_city_data = data['results'].first
  
      @city = City.new(
        name: new_city_data['name'],
        location: new_city_data['formatted_address'],
        geometry: new_city_data['geometry'].to_json, # Save geometry as JSON
        user_id: current_user.id
      )
  
      # Save photo reference if available
      photo_reference = new_city_data['photos']&.first&.dig('photo_reference')
      if photo_reference
        photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{photo_reference}&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
        @city.photo_url = photo_url
      end
  
      if @city.save
        render json: @city, status: :created
      else
        render json: { error: 'Failed to save city data', details: @city.errors.full_messages }, status: :unprocessable_entity
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
