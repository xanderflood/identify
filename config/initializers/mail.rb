Rails.application.configure do
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_options = {from: "no-reply@#{Rails.application.config.x.service_domain}"}
  config.action_mailer.default_url_options = { host: Rails.application.config.x.service_domain }
end
