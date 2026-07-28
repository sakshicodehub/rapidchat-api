class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :send_otp, :verify_otp ]
  def send_otp
    user = User.find_or_create_by!(
      phone: params[:phone]
    )
    otp = OtpService.store(user) if user.present?
    if otp.present?
      SmsService.send_sms(user.phone, otp)
      render json: { message: "OTP sent successfully" }, status: :ok
    else
      render json: { error: "Failed to send OTP" }, status: :unprocessable_entity
    end
  end

  def verify_otp
    phone = params.dig(:phone)
    user = User.find_by(phone: phone)
    if OtpService.verify(user, params[:otp])
      token = JwtService.encode(
        {
          user_id: user.id
        }
      )
      render json: { token: token, user: user }
    else
      render json: { error: "Invalid OTP" }, status: :unauthorized
    end
  end

  def logout
    # In a stateless JWT authentication system, you can't truly "log out" by invalidating the token on the server side.
    # However, you can implement token blacklisting or simply instruct the client to delete the token.
    render json: { message: "Logged out successfully" }, status: :ok
  end

end
