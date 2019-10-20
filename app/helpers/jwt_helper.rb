module JwtHelper
  InvalidToken = Class.new(StandardError)
  MissingToken = Class.new(StandardError)

  def claims_for_user user
    {
      sub: user.uuid,
      eml: user.email,
      iss: Rails.application.config.x.service_domain,
      iat: Time.now.to_i,
      exp: Time.now.to_i + Rails.application.config.x.jwt_ttl_seconds,
    }
  end

  def jwt_for_user user
    JWT.encode claims_for_user(user), Rails.application.config.x.jwt_signing_secret, 'HS256'
  end

  def claims_from_token token_string
    # decode will validate any standard claims that are present
    token = JWT.decode token_string, Rails.application.config.x.jwt_signing_secret, true, { algorithm: 'HS256' }

    # token[0] is the claims, token[1] is the header
    token[0]
  end

  def authenticate_jwt_string! token_string
    claims = claims_from_token token_string
    raise InvalidToken unless claims["sub"].present?

    claims
  end

  def authenticate_jwt! request
    token_string = token_from_request request
    raise MissingToken unless token.present?

    authenticate_jwt_string! token_string
  end

  def token_from_request request
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end
