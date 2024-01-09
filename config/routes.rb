Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "serch_product/serch", to: "serch_product#serch"
  get "serch_product/serch_result", to:"serch_product#serch_result"
  get "serch_product/category_view", to: "serch_product#category_view"
  post "serch_product/category_view", to: "serch_product#category_view"
  post "serch_product/category_all_delete", to: "serch_product#category_all_delete"
  get "serch_product/delete", to: "serch_product#delete"
  get "serch_product/regist_category", to: "serch_product#regist_category"
  #post "serch_product/regist_category", to: "serch_product#regist_category"
  get "buy_result/cart_view", to: "buy_result#cart_view"
  get "buy_result/cp_delete", to: "buy_result#cp_delete" 
  get "buy_result/buied", to: "buy_result#buied" 
  get "buy_result/purchased_view", to: "buy_result#purchased_view"
  get "buy_result/seller_purchased_view", to: "buy_result#seller_purchased_view"
  get "buy_result/seller_purchased_delete", to: "buy_result#seller_purchased_delete"
  #root "serch_product#category_view"
end


