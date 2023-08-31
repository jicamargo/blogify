class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
    # update the comments counter for each post
    @post.comments.each(&:update_comments_counter)
    # update the likes counter for each post
    @post.likes.each(&:update_likes_counter)
  end
end
