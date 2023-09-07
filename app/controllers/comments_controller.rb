class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

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
      @comment.update_comments_counter
      flash.notice = 'New comment added!'
      redirect_to user_post_path(@post.author, @post)
    else
      flash.alert = "Comment was not created! #{@comment.errors.full_messages.join(', ')}"
      redirect_to new_user_post_comment_path(@user, @post)
    end
  end

  # DELETE /users/:user_id/posts/:id
  def destroy
    @comment = Comment.find(params[:id])
    @post = Comment.find(params[:id]).post
    @user = @post.author

    if can?(:delete, @comment) # Use CanCanCan to authorize the deletion
      @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully deleted.'
    else
      redirect_to user_post_path(@user, @post), alert: 'You are not authorized to delete this post.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
