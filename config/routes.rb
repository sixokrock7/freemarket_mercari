Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registration',
    # registrations: 'users/sign_up/registration',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root to: 'products#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index]
  resources :users, only: [:edit]

  namespace :users do
    namespace :sign_up do
      get 'address', to: 'address#new'
      get 'registration', to: 'registration#new'

      resources :address, only: [:index]
      resources :payment, only: [:index]
      resources :done, only: [:index]
    end
  end
end
