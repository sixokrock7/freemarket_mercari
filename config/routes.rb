Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauthable_callbacks" }
  root to: 'products#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index]
  resources :users, only: [:edit]
end
