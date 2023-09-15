require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'title should be present' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    post = Post.new(title: 'My Post Title', text: 'This is the content of the post.', comments_counter: 0,
                    likes_counter: 0, author: user)
    post.title = nil
    expect(post).not_to be_valid
  end

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }

  describe '#recent_comments' do
    it 'returns the most recent comments' do
      user = User.new(name: 'John Doe', posts_counter: 0)
      user.save
      post = Post.new(title: 'My Post Title', text: 'This is the content of the post.', comments_counter: 0,
                      likes_counter: 0, author: user)

      # create a comment 2 days ago
      older_comment = Comment.new(text: '#1 This is the content of the comment.', post:, author: user,
                                  created_at: 2.days.ago)
      older_comment.save

      # create 3 comments today
      newer_comments = [Comment.new(text: '#2 This is the content of the comment.', post:, author: user),
                        Comment.new(text: '#3 This is the content of the comment.', post:, author: user),
                        Comment.new(text: '#4 This is the content of the comment.', post:, author: user)]
      newer_comments.each(&:save)

      expect(post.recent_comments(3)).to eq(newer_comments.reverse)
    end
  end
end
