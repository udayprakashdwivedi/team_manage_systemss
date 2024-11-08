class Api::V1::SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token
	include ResponseConcern

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = user.create_new_jwt_token
      response.set_header('Authorization', "Bearer #{token}")
      # if user.status == 'inactive'
      #   unauthorized('Your account is inactive.')
      #   return
      # end
      # UserDeviceDetail.find_or_initialize_by(user_id: user.id).update(fcm_token: params[:user][:fcm_token], device_type: params[:user][:device_type])
      success('Login successfully.', ActiveModelSerializers::SerializableResource.new(user, each_serializer: UserSerializer))
    else
      unauthorized('Invalid email or password')
    end
  end

  def destroy
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      
      begin
        jwt_payload = JWT.decode(token, Rails.application.credentials.jwt_secret_key).first
        user_id = jwt_payload['user_id']

        BlacklistToken.create(token: token) if User.find_by(id: user_id)
        
        success_message('Logged out successfully.')
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
       unauthorized('Invalid token.')
      end
    else
      bad_request(`Couldn't find an active session.`)
    end
  end
end
