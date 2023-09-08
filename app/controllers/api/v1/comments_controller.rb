class Api::V1::CommentsController < ApplicationController
  before_action :set_post
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /api/v1/posts/:post_id/comments
  def index
    @comments = @post.comments
    render json: @comments
  end

  def create
    @post = Post.find(params[:post_id])
    json_request = JSON.parse(request.body.read)
    text = json_request['text']
    author = @post.author

    @comment = @post.comments.new(text:, author:)
    if @comment.save
      render json: @comment
    else
      render json: { error: 'Invalid comment' }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
