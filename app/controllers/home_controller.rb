class HomeController < ApplicationController
  # TODO do I need to be using protect_from_forgery?

  ## these routes are open to the world
  def index
    if user_signed_in?
      redirect_to manage_path
      return
    end

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
    puts "HEYHEYHEYHEYHEY", @default_referrer_url
  end

  def manage
  end

  def logout
    sign_out current_user

    redirect_to root_path
  end
end
