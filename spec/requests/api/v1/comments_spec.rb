require 'swagger_helper'

# Define a method to configure the user_id and post_id parameters
def configure_user_and_post(user_id, post_id)
  let(:user_id) { user_id }
  let(:post_id) { post_id }
end

describe 'Comments API' do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string

      # Verify the current database:
      puts "database: #{ActiveRecord::Base.connection.current_database}"

      response '200', 'comments found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :integer },
                   text: { type: :string }
                 },
                 required: %w[text id]
               }

        parameter name: :user_id, in: :path, type: :string, required: true
        parameter name: :post_id, in: :path, type: :string, required: true

        configure_user_and_post('1', '1')
        run_test!
      end

      response '404', 'post not found' do
        configure_user_and_post('1', '985411') # An ID that doesn't exist in the database
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    post 'Creates a new comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'comment created' do
        configure_user_and_post('1', '1')
        let(:comment) { { text: 'THIS IS A NEW COMMENT USING THE API ENDPOINT' } }
        run_test!
      end

      response '404', 'post not found' do
        configure_user_and_post('1', '985411') # An ID that doesn't exist in the database
        let(:comment) { { text: 'THIS IS A NEW COMMENT USING THE API ENDPOINT' } }
        run_test!
      end

      response '422', 'invalid request' do
        configure_user_and_post('1', '1')
        let(:comment) { { text: '' } } # Invalid request with empty text
        run_test!
      end
    end
  end
end
