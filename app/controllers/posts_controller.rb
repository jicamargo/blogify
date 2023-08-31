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

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post } }
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    #examine the post object
    puts ">>>>>>>>>>>>>>this is the post: #{@post}"
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
