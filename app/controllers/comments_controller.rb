class CommentsController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user
    if @comment.save
      flash.notice = 'New comment added!'
      redirect_to user_post_path(@post.author, @post)
    else
      flash.alert = "Comment was not created! #{@comment.errors.full_messages.join(', ')}"
      redirect_to new_user_post_comment_path(@user, @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
