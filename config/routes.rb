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
  get "user/destroy"
  get "seller/destroy"
  post "seller/set_keyword"#, to: "seller/set_keyword"
  get "serch_product/cart_in", to: "serch_product#cart_in"
  get "serch_product/serch", to: "serch_product#serch"
  get "serch_product/serch_result", to:"serch_product#serch_result"
  get "serch_product/category_view", to: "serch_product#category_view"
  post "serch_product/category_view", to: "serch_product#category_view"
  post "serch_product/category_all_delete", to: "serch_product#category_all_delete"
  get "serch_product/delete", to: "serch_product#delete"
  get "serch_product/regist_category", to: "serch_product#regist_category"
  get "serch_product/product_pages", to: "serch_product#product_pages"
  #post "serch_product/regist_category", to: "serch_product#regist_category"
  get "buy_result/cart_view", to: "buy_result#cart_view"
  get "buy_result/cp_delete", to: "buy_result#cp_delete" 
  get "buy_result/buied", to: "buy_result#buied" 
  get "buy_result/purchased_view", to: "buy_result#purchased_view"
  get "buy_result/seller_purchased_view", to: "buy_result#seller_purchased_view"
  get "buy_result/seller_purchased_delete", to: "buy_result#seller_purchased_delete"
  get "buy_result/product_all", to: "buy_result#product_all"
  get "buy_result/ad_product", to: "buy_result#ad_product"
  #root "serch_product#category_view"
end


