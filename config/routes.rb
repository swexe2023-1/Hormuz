Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "serch_product/serch", to: "serch_product#serch"
  get "serch_product/category_view", to: "serch_product#category_view"
  post "serch_product/category_view", to: "serch_product#category_view"
  post "serch_product/category_all_delete", to: "serch_product#category_all_delete"
  get "serch_product/regist_category", to: "serch_product#regist_category"
  post "serch_product/regist_category", to: "serch_product#regist_category"
  get "buy_result/cart_view", to: "buy_result#cart_view"
  #root "serch_product#category_view"
end


