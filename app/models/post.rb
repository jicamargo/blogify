class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes
  has_rich_text :text

  # custom method which returns the 5 most recent comments for a given post.
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def set_counters_to_zero
    self.comments_counter = 0
    self.likes_counter = 0
  end
end
