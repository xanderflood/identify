Rails.application.configure do
  config.action_mailer.default_url_options = { host: Rails.application.config.x.service_domain }
end
