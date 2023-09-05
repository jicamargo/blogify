class UsersController < ApplicationController
  def index
    @users = User.all
    # update the posts counter for each user
    @users.each(&:update_posts_counter)
  end

  def show
    @user = User.includes(posts: [{ comments: :author }, :comments]).find(params[:id])
    
    # update the comments counter for each post
    # update the likes counter for each post
    @user.posts.each do |post|
      post.comments.each(&:update_comments_counter)
      post.likes.each(&:update_likes_counter)
    end
  end
end
