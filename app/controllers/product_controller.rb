class ProductController < ApplicationController
    def new
      @product = Product.new
    end
    
    def create
      @product = Product.new(pid: params[:pid], seller_id: params[:seller_id],
      price: params[:price], description: params[:description], 
      img: params[:img])
      @product.save
      redirect_to seller_index_path
    end
    
    def destroy
      product = Product.find(params[:id])
      product.destroy
      redirect_to seller_index_path
    end
end
