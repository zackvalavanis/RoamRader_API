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
      @comment.save
  end 

end