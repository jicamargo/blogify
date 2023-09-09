class Api::V1::PostsController < ApplicationController
  # GET /api/v1/users/:user_id/posts
  def index
    # Check if the user exists, and if not, return a 404 response
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
      return
    end

    # Retrieve the user's posts and return them in the response
    @posts = @user.posts
    render json: @posts
  end
end
