require 'swagger_helper'

RSpec.describe 'api/v1/team_members', type: :request do

  path '/api/v1/teams/{team_id}/team_members' do
    # You'll want to customize the parameter types...
    parameter name: 'team_id', in: :path, type: :string, description: 'team_id'

    get('list team_members') do
      response(200, 'successful') do
        let(:team_id) { '123' }

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

    post('create team_member') do
      response(200, 'successful') do
        let(:team_id) { '123' }

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

  path '/api/v1/teams/{team_id}/team_members/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'team_id', in: :path, type: :string, description: 'team_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show team_member') do
      response(200, 'successful') do
        let(:team_id) { '123' }
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

    delete('delete team_member') do
      response(200, 'successful') do
        let(:team_id) { '123' }
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
