# spec/integration/sessions_spec.rb

require 'swagger_helper'

describe 'Api::V1::Sessions' do
  path '/api/v1/login' do
    post 'Log in a user' do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'uday@gmail.com' },
              password: { type: :string, example: '123456' }
            },
            required: ['email', 'password']
          }
        }
      }


      response '200', 'Login successful' do
        let(:user) { { email: 'uday@gmail.com', password: '123456' } }
        run_test!
      end

      response '401', 'Invalid email or password' do
        let(:user) { { email: 'wrong@example.com', password: 'password123' } }
        run_test!
      end
    end
  end
end
