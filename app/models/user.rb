class User < ApplicationRecord
  # include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :confirmable
  #  :jwt_authenticatable, :recoverable, :rememberable, jwt_revocation_strategy: self

  before_create :set_default_values

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

  # this method is called when a user is created to set default values (photo and posts_counter)
  def set_default_values
    self.photo ||= "https://randomuser.me/api/portraits/men/#{rand(1..100)}.jpg"
    self.posts_counter = 0
  end

  # define roles for users
  def admin?
    role == 'admin'
  end

  # Method to generate a JWT token for this user
  def generate_jwt
    payload = { user_id: id }
    JWT.encode(payload, Rails.application.config.jwt_secret, 'HS256')
  end
end
