class ApplicationController < ActionController::API
  before_action :authorize_request

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @current_user = User.find(JsonWebToken.decode(header)['user_id']) if header
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end
