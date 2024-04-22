class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private 
  def current_user
    token = request.headers["Authorization"].to_s
    User.find_for_database_authentication(authentication_token: token)
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
end

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end