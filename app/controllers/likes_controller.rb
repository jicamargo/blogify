class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @like = @post.likes.new(author: current_user)

    return unless @like.save

    @like.update_likes_counter
    redirect_to user_post_path(@post.author, @post)
  end
end
