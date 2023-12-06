class UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    user = User.new(user_params)
    if user.save
      render json: { token: JsonWebToken.encode(user_id: user.id), user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
