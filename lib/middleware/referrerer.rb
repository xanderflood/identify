class Referrerer
  def initialize app, referrer_cookie_ttl = 30*60
    @app = app
    @referrer_cookie_ttl = referrer_cookie_ttl
  end

  def call env
    req = Rack::Request.new(env)
    referer = req.params["referrer_url"]

    status, headers, body = @app.call(env)

    if referer.nil? || referer.empty?
      [status, headers, body]
    else
      response = Rack::Response.new body, status, headers
      response.set_cookie("identify_referrer_url", {
        value: referer,
        secure: true,
        expires: Time.now + @referrer_cookie_ttl,
      })
      response.finish
    end
  end
end
