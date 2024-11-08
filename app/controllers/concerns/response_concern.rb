# frozen_string_literal: true

module ResponseConcern
  extend ActiveSupport::Concern

  # Status Code
  HTTP_STATUS_CODE_200 = 200 # success response
  HTTP_STATUS_CODE_201 = 201 # Allready Exists
  HTTP_STATUS_CODE_400 = 400 # Bad Request
  HTTP_STATUS_CODE_401 = 401 # Un-authorized request
  HTTP_STATUS_CODE_403 = 403 # Already exists
  HTTP_STATUS_CODE_404 = 404 # Not Found
  HTTP_STATUS_CODE_405 = 405 # Method Not Allowed
  HTTP_STATUS_CODE_411 = 411 # Email and Password wrong
  HTTP_STATUS_CODE_422 = 422 # Unprocessable entity
  HTTP_STATUS_CODE_433 = 433 # User not verified
  HTTP_STATUS_CODE_500 = 500 # Server Error

  private

  # Success method
  def success(message, data)
    render json: {
      status: HTTP_STATUS_CODE_200,
      message: message,
      data: data
    }, status: :ok
  end

  # Success method with message
  def success_message(message, data = {})
    render json: {
      status: HTTP_STATUS_CODE_200,
      message: message,
      data: data
    }, status: :ok
  end

  # Bad request
  def bad_request(message)
    render json: {
      status: HTTP_STATUS_CODE_400,
      message: message
    }, status: :bad_request
  end

  # Unauthorized
  def unauthorized(message)
    render json: {
      status: HTTP_STATUS_CODE_401,
      message: message,
      data: {}
    }, status: :unauthorized
  end

  # Not found
  def not_found(message)
    render json: {
      status: HTTP_STATUS_CODE_404,
      message: message,
      data: []
    }, status: :not_found
  end

  # Unprocessable entity
  def unprocessable_entity(message)
    render json: {
      status: HTTP_STATUS_CODE_422,
      message: message.is_a?(Array) ? message.join(', ') : message,
      data: {}
    }, status: :unprocessable_entity
  end

  # Internal server error
  def internal_server_error(message)
    render json: {
      status: HTTP_STATUS_CODE_500,
      message: message
    }, status: :internal_server_error
  end
end
