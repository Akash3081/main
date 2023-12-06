class AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { token: JsonWebToken.encode(user_id: user.id), user: user }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
