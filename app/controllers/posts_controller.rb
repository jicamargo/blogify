class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

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

  # DELETE /users/:user_id/posts/:id
  def destroy
    @post = Post.find(params[:id])
    @user = @post.author

    if can?(:delete, @post) # Use CanCanCan to authorize the deletion
      @post.comments.destroy_all
      @post.likes.destroy_all
      @post.destroy
      redirect_to user_posts_path(@user), notice: 'Post was successfully deleted.'
    else
      redirect_to user_posts_path(@user), alert: 'You are not authorized to delete this post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
