Rails.application.routes.draw do
  #resources :user
  get 'user/index'
  root 'user#index'
  get 'user/new'
  post 'user/signin'
  get 'user/logout'
  get 'user/login'
  resources :user, only: [:create, :destroy]
  resources :seller, only: [:index,:new,:create,:destroy]
  post 'seller/signin'
  get 'seller/logout'
  get 'seller/login'
  resources :admin, only: [:index,:new,:create,:destroy]
  post 'admin/signin'
  get 'admin/logout'
  resources :product, only: [:new,:create,:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
