class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
    # update the comments counter for each post
    @post.comments.each(&:update_comments_counter)
    # update the likes counter for each post
    @post.likes.each(&:update_likes_counter)
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    @post.set_counters_to_zero
    if @post.save
      flash.notice = 'New post added!'
      redirect_to user_path(@user)
    else
      flash.alert = "Post was not created! #{@post.errors.full_messages.join(', ')}"
      redirect_to new_user_post_path(@user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
