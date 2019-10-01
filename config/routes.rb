Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    # 302 (temporary redirect) to the catalog service
    # this is temporary so that unauthenticated users don't
    # get whisked away when they're trying to sign in.
    root to: 'home#index', name: "home"
  end

  unauthenticated do
    devise_scope :user do
      get 'login', to: "devise/sessions#new", name: "login"
    end
  end
end
