class HomeController < ApplicationController
  def index
  end

  def redirect
    @default_referrer_url = Rails.application.config.x.default_referrer_url
  end

  def tmp
  end
end
