class HomeController < ApplicationController
  ## these routes are open to the world
  def index
    if user_signed_in?
      redirect_to manage_path
      return
    end

    set_referrer_cookie
    redirect_to login_path
  end

  def refresh
    # every endpoint automatically refreshes the token for
    # authenticated users, so all we need to do is check
    return 401 unless user_signed_in?

    204 # no content
  end

  ## these routes are only accessible to logged-in users
  def redirect
    @default_referrer_url = Rails.application.config.x.default_referrer_url
    @default_referrer_url = manage_path unless @default_referrer_url.present?

    @referrer_url_cookie = Rails.application.config.x.referrer_cookie_name
  end

  def manage
  end

  def logout
    sign_out current_user

    redirect_to root_path
  end

  private
  def set_referrer_cookie
    referrer = params["referrer_url"]

    if referrer.present?
      cookies[Rails.application.config.x.referrer_cookie_name] = {
        value: referrer,
        path: '/', # required in order to delete the cookie
        expires: Time.now + Rails.application.config.x.referrer_cookie_ttl_seconds.seconds,
      }
    end
  end
end
