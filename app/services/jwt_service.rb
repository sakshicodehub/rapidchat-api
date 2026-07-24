class JwtService
  SECRET = Rails.application.credentials.jwt_secret

  def self.encode(payload, exp = 60.minutes.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(
      payload,
      SECRET,
      "HS256"
    )
  end


  def self.decode(token)
    decoded = JWT.decode(
      token,
      SECRET,
      true,
      algorithm: "HS256"
    )

    decoded[0]
  rescue => e
    Rails.logger.error "JWT ERROR: #{e.class} - #{e.message}"
    nil
  end
end
