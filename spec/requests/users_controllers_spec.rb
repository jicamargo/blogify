require 'rails_helper'

RSpec.describe 'UsersControllers', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template('index')
    end

    it 'renders the correct placeholder in the response body' do
      get users_path
      expect(response.body).to include('List of Users')
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

    it 'returns a successful response' do
      get user_path(id: user.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_path(id: user.id)
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get user_path(id: user.id)
      expect(response.body).to include('User Profile')
    end
  end
end
