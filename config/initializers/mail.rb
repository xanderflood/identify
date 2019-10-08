Rails.application.configure do
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_options = { from: config.x.notifications_source_email }
  config.action_mailer.default_url_options = { host: config.x.service_domain }
end
