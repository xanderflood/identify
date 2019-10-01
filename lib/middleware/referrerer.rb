class Referrerer
  def initialize app
    @app = app
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

        #TODO make this TTL more configurable
        expires: Time.now + 30*60,
      })
      response.finish
    end
  end
end
