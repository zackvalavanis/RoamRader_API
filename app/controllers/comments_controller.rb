class CommentsController < ApplicationController

  def index 
    @comments = Comment.all
    render :index
  end 

  def create 
      @comment = Comment.new( 
        content: params[:content], 
        user_id: params[:user_id],
        city_id: params[:city_id]
      )
      if @comment.save
        render json: @comment, status: :created
      else
        Rails.logger.error "Comment could not be saved: #{@comment.errors.full_messages.join(', ')}"
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
  end 

end