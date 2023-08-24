require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'John Doe', posts_counter: 0) }
  let(:post) do
    Post.new(title: 'My Post Title', text: 'This is the content of the post.', comments_counter: 0, likes_counter: 0,
             author: user)
  end

  it 'should be valid with valid attributes' do
    comment = Comment.new(author: user, post:, text: 'This is a comment.')
    expect(comment).to be_valid
  end

  it 'should not be valid without an author' do
    comment = Comment.new(post:, text: 'This is a comment.')
    expect(comment).to_not be_valid
  end

  it 'should not be valid without a post' do
    comment = Comment.new(author: user, text: 'This is a comment.')
    expect(comment).to_not be_valid
  end

  # test the update_comments_counter method
  describe '#update_comments_counter' do
    it 'updates the comments counter for the associated post' do
      comment = Comment.new(author: user, post:, text: 'This is a comment.')
      comment.save

      expect do
        comment.update_comments_counter
      end.to change { post.comments_counter }.by(1)
    end
  end
end
