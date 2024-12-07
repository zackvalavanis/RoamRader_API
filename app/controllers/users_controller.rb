class UsersController < ApplicationController

  def index 
    @users = User.all
    render :index
  end 

  def show 
    @user = User.find_by(id: params[:id])
    render :show
  end 

  def create

    user = User.new(
      name: params[:name],
      email: params[:email],
      is_admin: params[:is_admin].nil? ? false : params[:is_admin],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
  
    if @user
      if @user.destroy
        render json: { message: 'The user has been deleted' }
      else
        render json: { message: 'Error occurred while deleting the user' }
      end
    else
      render json: { message: 'User not found' }
    end
  end

end
