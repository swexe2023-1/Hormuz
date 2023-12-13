class ProductController < ApplicationController
    def new
      @product = Product.new
    end
    
    def create
      @product = Product.new(pid: params[:product][:pid], seller_id: params[:product][:seller_id],
      price: params[:product][:price], description: params[:product][:description], 
      img: params[:product][:img])
      @product.save
      redirect_to seller_index_path
    end
    
    def destroy
      product = Product.find(params[:id])
      product.destroy
      redirect_to seller_index_path
    end
end
