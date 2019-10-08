Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              config.x.smtp_address,
    port:                 config.x.smtp_port,
    domain:               config.x.service_domain,
    user_name:            config.x.smtp_username,
    password:             config.x.smtp_password,
    authentication:       'plain',
    enable_starttls_auto: true
  }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_options = { from: config.x.notifications_source_email }
  config.action_mailer.default_url_options = { host: config.x.service_domain }
end
