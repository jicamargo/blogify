class Api::V1::CommentsController < ApplicationController
  before_action :set_post

  # GET /api/v1/posts/:post_id/comments
  def index
    @comments = @post.comments
    render json: @comments
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
