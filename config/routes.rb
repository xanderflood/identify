Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: 'home#index'

    devise_scope :user do
      get 'login', to: "devise/sessions#new"
    end
  end

  authenticated :user do
    # TODO change this to `root to:`
    get '/', to: 'home#index'
    get 'redirect', to: 'home#redirect'
    get 'TODO', to: 'home#tmp'
  end

  # TODO have this redirect or something? this is a convenience function
  # get 'logout'

  # TODO for use by other services
  # post 'refresh'    # check if the token is almost stale
                      # refresh the token if needed and possible
                      # if not, the other service should redirect to root
end
