class ApplicationController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user

  private


  def authenticate_user!
    token = request.headers["Authorization"]
            &.split(" ")
            &.last
    payload = JwtService.decode(token)

    if payload
      @current_user = User.find(payload["user_id"])
      unless @current_user
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    else
      render json: {
        error: "Unauthorized"
      },
      status: :unauthorized
    end
  end
end
