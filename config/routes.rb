Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauthable_callbacks" }
  root to: 'products#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index]
  resources :users, only: [:edit]
  
  namespace :users do
    namespace :sign_up do
      resources :registration, only: [:index]
      resources :address, only: [:index]
      resources :payment, only: [:index]
      resources :done, only: [:index]
    end
  end
end
