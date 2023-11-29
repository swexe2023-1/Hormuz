Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "serch_product/serch", to: "serch_product#serch"
  get "buy_result/cart_view", to: "buy_result#cart_view"
end
