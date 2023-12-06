class JsonWebToken
  def self.encode(payload, expiration = 24.hours.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base).first
  rescue JWT::ExpiredSignature
    nil
  end
end
