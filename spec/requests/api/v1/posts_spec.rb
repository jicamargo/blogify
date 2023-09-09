require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/users/{user_id}/posts' do
    get 'Retrieves posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      # verify the current database:
      puts "database: #{ActiveRecord::Base.connection.current_database}"


      response '200', 'posts found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   title: { type: :string },
                   text: { type: :string }
                 },
                 required: %w[title text]
               }

        # Define `user_id` within the example group
        parameter name: :user_id, in: :path, type: :string, required: true

        let(:user_id) { '1' }
        run_test!
      end

      response '404', 'user not found' do
        let(:user_id) { 985_411 }
        run_test!
      end
    end
  end
end
