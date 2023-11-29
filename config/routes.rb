Rails.application.routes.draw do
  root 'user#index'
  post 'user/login'
  get 'user/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
