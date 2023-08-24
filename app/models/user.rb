class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  # custom method to return the three most recent posts of this user
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  # method that updates the posts counter for this user.
  def update_posts_counter
    update(posts_counter: posts.count)
  end
end
