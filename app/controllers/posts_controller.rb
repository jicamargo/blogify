class PostsController < ApplicationController
  def index
    @user = User.includes(posts: [{ comments: :author }, :comments]).find(params[:user_id])
  end

  def show
    @post = Post.includes([{ comments: :author }, :comments]).find_by(id: params[:id])
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
