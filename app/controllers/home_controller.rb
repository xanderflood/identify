class HomeController < ApplicationController
  def index
  end

  def redirect
    # TODO
    # 1) if unauthenticated, redirect to login page
    # 2) if authenticated, render a view, and update JWT cookie
    # 3) the view has placeholder text, + javascript that
    #      checks your referrer_url cookie

    # have a middleware that _always_ freshens JWTs for
    # authenticated users?
  end

  def tmp
  end
end
