class OtpService
  OTP_EXPIRE_TIME = 5.minutes


  def self.generate
    SecureRandom.random_number(900000) + 100000
  end


  def self.store(user)
    otp = generate
    otp_varification = OtpVerification.find_or_initialize_by(phone: user.phone)

    otp_varification.update!(
      user: user,
      phone: user.phone,
      otp_digest: BCrypt::Password.create(otp),
      expires_at: OTP_EXPIRE_TIME.from_now,
      verified_at: Time.current,
      attempts: otp_varification.attempts + 1
    )

    otp
  end


  def self.verify(user, otp)
    return false if user.nil?
    otp_varification = OtpVerification.find_by(phone: user.phone)

    return false if otp_varification.expires_at.nil?
    return false if Time.current > otp_varification.expires_at


    BCrypt::Password.new(otp_varification.otp_digest) == otp.to_s
  end
end
