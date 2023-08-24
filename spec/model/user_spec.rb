require 'rails_helper'

RSpec.describe User, type: :model do
  it 'name should be present' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    expect(user).to be_valid

    user.name = nil
    expect(user).to_not be_valid
  end

  it 'posts_counter should be numeric and greater than or equal to 0' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    expect(user).to be_valid

    user.posts_counter = 'not_a_number'
    expect(user).to_not be_valid

    user.posts_counter = -1
    expect(user).to_not be_valid
  end

  # test the custom method recent_posts
  describe '#recent_posts' do
    it 'returns the most recent posts' do
      user = User.new(name: 'John Doe', posts_counter: 0)
      user.save

      # create a post 2 days ago
      older_post = Post.new(title: 'My Post Title', text: 'This is the content of the post.', comments_counter: 0,
                            likes_counter: 0, author: user, created_at: 2.days.ago)
      older_post.save

      # create 2 posts today
      newer_posts = [
        Post.new(title: '#1 My Post Title', text: 'This is the content of the post.', comments_counter: 0,
                 likes_counter: 0, author: user),
        Post.new(title: '#2 My Post Title', text: 'This is the content of the post.', comments_counter: 0,
                 likes_counter: 0, author: user)
      ]
      newer_posts.each(&:save)

      expect(user.recent_posts(2)).to eq(newer_posts.reverse)
    end
  end

  # test the update_posts_counter method
  describe '#update_posts_counter' do
    it 'updates the posts counter for the user' do
      user = User.new(name: 'John Doe', posts_counter: 0)
      user.save
      # create a post to be associated with this user
      post = Post.new(title: 'My Post Title', text: 'This is the content of the post.', comments_counter: 0,
                      likes_counter: 0, author: user, created_at: 2.days.ago)
      post.save

      expect do
        user.update_posts_counter
      end.to change { user.posts_counter }.by(1)
    end
  end
end
