class AuthenticationTokenService
  HMAC_SECRET = "blog_app_authentication".freeze
  ALGORITHM = "HS384".freeze

  def self.encode(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM })
    decoded_token[0]["user_id"]
  end
end
