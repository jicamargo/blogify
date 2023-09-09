require 'swagger_helper'

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

        # Define `user_id` and `post_id` within the example group
        parameter name: :user_id, in: :path, type: :string, required: true
        parameter name: :post_id, in: :path, type: :string, required: true

        let(:user_id) { '1' }
        let(:post_id) { '1' }
        run_test!
      end

      response '404', 'post not found' do
        let(:user_id) { '1' }
        let(:post_id) { '985411' } # An ID that doesn't exist in the database
        run_test!
      end
    end

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
        let(:user_id) { '1' }
        let(:post_id) { '1' }
        let(:comment) { { text: 'THIS IS A NEW COMMENT USING THE API ENDPOINT' } }
        run_test!
      end

      response '404', 'post not found' do
        let(:user_id) { '1' }
        let(:post_id) { '985411' } # An ID that doesn't exist in the database
        let(:comment) { { text: 'THIS IS A NEW COMMENT USING THE API ENDPOINT' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user_id) { '1' }
        let(:post_id) { '1' }
        let(:comment) { { text: '' } } # Invalid request with empty text
        run_test!
      end
    end
  end
end
