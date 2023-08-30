require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do
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
      expect(response.body).to include('This is the list of Users')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get user_path(id: 1)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_path(id: 1)
      expect(response).to render_template('show')
    end

    it 'renders the correct placeholder in the response body' do
      get user_path(id: 1)
      expect(response.body).to include('This is the User profile')
    end
  end
end
