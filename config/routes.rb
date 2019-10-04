Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  unauthenticated do
    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
    end
  end

  post 'refresh', to: 'home#refresh'

  authenticated :user do
    get 'redirect', to: 'home#redirect'
    get 'manage', to: 'home#manage'
    get 'logout', to: 'home#logout'
  end
end
