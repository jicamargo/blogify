class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :find_post, only: %i[index create]

  # GET /api/v1/posts/:post_id/comments
  def index
    @comments = @post.comments
    render json: @comments
  end

  def create
    json_request = JSON.parse(request.body.read)
    text = json_request['text']
    author = @post.author

    if text.present? # Verify that the text is not empty
      @comment = @post.comments.new(text:, author:)

      if @comment.save
        render json: @comment, status: :created
      else
        render json: { error: 'Invalid comment' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Text cannot be empty' }, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])

    return if @post

    render json: { error: 'Post not found' }, status: :not_found
  end
end
