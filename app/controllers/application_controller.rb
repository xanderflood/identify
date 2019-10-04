class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :maybe_refresh_jwt

  def after_sign_in_path_for(resource)
    redirect_path
  end

  def maybe_refresh_jwt
    return if !user_signed_in?

    token = helpers.jwt_for_user current_user
    cookies[Rails.application.config.x.jwt_cookie_name] = {
      value: token,
      domain: Rails.application.config.x.authorization_domain,
    }
  end
end
