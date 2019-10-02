class Referrerer
  def initialize app, referrer_cookie_ttl_seconds = 30*60
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
      response.set_cookie("_identify_referrer_url", {
        value: referrer,
        path: '/', # required in order to delete the cookie
        expires: Time.now + @referrer_cookie_ttl_seconds,
      })
      response.finish
    end
  end
end
