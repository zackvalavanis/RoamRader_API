class HomesController < ApplicationController
  def index 
    render json: {message: 'HomePage'}
  end 
end
