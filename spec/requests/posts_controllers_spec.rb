require 'rails_helper'

RSpec.describe 'PostsControllers', type: :request do
  describe 'GET #index' do
    let!(:user) do
      User.create(
        name: 'Test user',
        photo: 'https://randomuser.me/api/portraits/men/1.jpg',
        bio: 'Bio for test user',
        posts_counter: 0
      )
    end

    it 'returns a successful response' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template('index')
    end

    it 'renders the correct placeholder in the response body' do
      get user_posts_path(user_id: user.id)
      expect(response.body).to include('Test user')
    end
  end

  describe 'GET #show' do
    let!(:user) do
      User.create(
        name: 'Test user',
        photo: 'https://randomuser.me/api/portraits/men/1.jpg',
        bio: 'Bio for test user',
        posts_counter: 0
      )
    end

    let!(:post) do
      user.posts.create(
        title: 'Test Post',
        text: 'This is the text of the test post',
        comments_counter: 2,
        likes_counter: 5
      )
    end

    it 'returns a successful response' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include('Test Post')
    end
  end
end
