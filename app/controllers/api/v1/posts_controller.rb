class Api::V1::PostsController < ApplicationController
  before_action :set_user
  
  # GET /api/v1/users/:user_id/posts
  def index
    @posts = @user.posts
    render json: @posts
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
