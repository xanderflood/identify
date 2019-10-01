Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  authenticated :user do
    # 302 (temporary redirect) to the catalog service
    # this is temporary so that unauthenticated users don't
    # get whisked away when they're trying to sign in.1
    root to: 'home#index', name: "home"
  end

  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new", name: "login"
    end
  end
end
