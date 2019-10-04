require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

require_relative "../lib/middleware/referrerer"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Identify
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # load config from environment
    config.x.service_domain              = ENV["SERVICE_DOMAIN"] || fail("Environment variable SERVICE_DOMAIN must be set")
    config.x.authorization_domain        = ENV["AUTHORIZATION_DOMAIN"] || fail("Environment variable AUTHORIZATION_DOMAIN must be set")
    config.x.jwt_signing_secret          = ENV["JWT_SIGNING_SECRET"] || fail("Environment variable JWT_SIGNING_SECRET must be set")

    # NOTE: blank default_referrer_url causes it to use '/manage',
    # which has account management links
    config.x.default_referrer_url              = ENV["DEFAULT_REFERRER_URL"]
    config.x.referrer_cookie_name              = ENV["REFERRER_COOKIE_NAME"] || "_identify_referrer_url"
    config.x.jwt_cookie_name                   = ENV["JWT_COOKIE_NAME"] || "_identify_jwt_string"
    config.x.referrer_cookie_ttl_seconds       = ENV["REFERRER_COOKIE_EXPIRATION_SECONDS"] ? ENV["REFERRER_COOKIE_EXPIRATION_SECONDS"].to_i : 1800  # 30 minutes
    config.x.jwt_ttl_seconds                   = ENV["JWT_COOKIE_EXPIRATION_SECONDS"]      ? ENV["JWT_COOKIE_EXPIRATION_SECONDS"].to_i      : 21600 # 6 hours
    config.x.identify_sessions_timeout_seconds = ENV["IDENTIFY_SESSIONS_TIMEOUT_SECONDS"]  ? ENV["IDENTIFY_SESSIONS_TIMEOUT_SECONDS"]       : 86400 # 1 day
  end
end
