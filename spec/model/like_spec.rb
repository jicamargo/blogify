require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'John Doe', posts_counter: 0) }
  let(:post) do
    Post.new(title: 'My Post Title', text: 'This is the content of the post.', comments_counter: 0, likes_counter: 0,
             author: user)
  end

  it 'should be valid with valid attributes' do
    like = Like.new(author: user, post:)
    expect(like).to be_valid
  end

  it 'should not be valid without an author' do
    like = Like.new(post:)
    expect(like).to_not be_valid
  end

  it 'should not be valid without a post' do
    like = Like.new(author: user)
    expect(like).to_not be_valid
  end

  # test the update_likes_counter method
  describe '#update_likes_counter' do
    it 'updates the likes counter for the associated post' do
      like = Like.new(author: user, post:)
      like.save

      expect do
        like.update_likes_counter
      end.to change { post.likes_counter }.by(1)
    end
  end
end
