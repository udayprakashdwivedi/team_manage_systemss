require 'swagger_helper'

RSpec.describe 'api/v1/teams', type: :request do

  path '/api/v1/teams' do
    get 'Fetch all teams for current user' do
      response '200', 'Teams fetched successfully' do
        let(:Authorization) { "Bearer #{token}" }
        run_test!
      end
    end

    post 'Create a new team' do
      consumes 'application/json'
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Team Alpha' },
          description: { type: :string, example: 'A description of Team Alpha' }
        },
        required: ['name']
      }

      response '201', 'Team created' do
        let(:Authorization) { "Bearer #{token}" }
        let(:team) { { name: 'Team Alpha', description: 'A description of Team Alpha' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:Authorization) { "Bearer #{token}" }
        let(:team) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/teams/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show team') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update team') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update team') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete team') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
