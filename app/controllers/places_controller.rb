class PlacesController < ApplicationController
  def index 
   @places = Place.all
    # @places = Place.where(user_id: current_user.id)
  end

  def show
    @place = Place.find_by(id: params[:id])
    # if place.user = current_user
    #   render :show
    # else 
    #   render json: { error: 'The user is not logged in'}
  end 

  def create 
    @place = Place.new( 
      
    )

end
