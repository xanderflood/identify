class Referrerer
  def initialize app, referrer_cookie_ttl_seconds
    @app = app
    @referrer_cookie_ttl_seconds = referrer_cookie_ttl_seconds
  end

  def call env
    req = Rack::Request.new(env)
    referrer = req.params["referrer_url"]

    status, headers, body = @app.call(env)

    if referrer.nil? || referrer.empty?
      [status, headers, body]
    else
      response = Rack::Response.new body, status, headers
      response.set_cookie(
        Rails.application.config.x.referrer_cookie_name,
        {
          value: referrer,
          path: '/', # required in order to delete the cookie
          # expires: Time.now + @referrer_cookie_ttl_seconds.seconds,
          # TODO why does the expiry cause the token not to be set?
        },
      )
      response.finish
    end
  end
end
