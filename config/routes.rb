Rails.application.routes.draw do
  #resources :user
  get 'user/index'
  root 'user#index'
  get 'user/new'
  post 'user/login'
  get 'user/logout'
  get 'user/main'
  resources :user, only: [:create, :destroy]
  resources :seller, only: [:index,:new,:create,:destroy]
  post 'seller/login'
  get 'seller/logout'
  get 'seller/main'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
