module JwtHelper
  def claims_for_user user
    {
      sub: user.uuid,
      iss: Rails.application.config.x.service_domain,
      iat: Time.now.to_i,
      exp: Time.now.to_i + Rails.application.config.x.jwt_ttl_seconds,
    }
  end

  def jwt_for_user user
    JWT.encode claims_for_user(user), Rails.application.config.x.jwt_signing_secret, 'HS256'
  end

  def claims_from_token token_string
    token = JWT.decode token_string, Rails.application.config.x.jwt_signing_secret, true, { algorithm: 'HS256' }

    # token[0] is the claims, token[1] is the header
    token[0]
  end

  def authenticate_jwt_string token_string
    claims = claims_from_token token_string
    # TODO
  end

  def authenticate_jwt
    #  TODO
  end
end
