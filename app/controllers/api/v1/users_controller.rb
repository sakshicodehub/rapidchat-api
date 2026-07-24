class Api::V1::UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_param)
    render json: { succes: true, data: user }, status: :ok
  end

  privare

  def user_params
    params.require(:user).permit(:name, :phone, :last_seen_at, :online, :about, :avatar_url)
  end
end
