class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post

  # method that updates the likes counter for a post.
  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
