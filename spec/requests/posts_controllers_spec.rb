require 'rails_helper'

RSpec.describe 'PostsControllers', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get user_posts_path(user_id: 1)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user_id: 1)
      expect(response).to render_template('index')
    end

    it 'renders the correct placeholder in the response body' do
      get user_posts_path(user_id: 1)
      expect(response.body).to include('This is a list of posts for user ID')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get user_post_path(user_id: 1, id: 1)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(user_id: 1, id: 1)
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get user_post_path(user_id: 1, id: 1)
      expect(response.body).to include('This is the details page for post ID')
    end
  end
end
