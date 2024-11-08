require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/api/v1/users' do
    get 'Fetch all users' do
      response '200', 'Users fetched successfully' do
        let!(:users) { create_list(:user, 5) }

        run_test! do |response|
          expect(response.status).to eq(200)
          expect(response.body).to include('users')
        end
      end
    end
  end
end
