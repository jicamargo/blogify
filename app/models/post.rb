class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  # custom method which returns the 5 most recent comments for a given post.
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
