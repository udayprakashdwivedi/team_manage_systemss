class Api::V1::BaseController < ApplicationController
  include ResponseConcern
  before_action :authenticate_user

  private

  def authenticate_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last

      begin

        jwt_payload = JWT.decode(token, Rails.application.credentials.jwt_secret_key).first
        @current_user = User.find(jwt_payload['user_id'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        unauthorized('Invalid token.')
      end
    else
      unauthorized('Authorization header not found.')
    end
  end
end

