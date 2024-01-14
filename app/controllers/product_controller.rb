require 'digest'
class ProductController < ApplicationController
    def new
      @product = Product.new
    end
    
    def create
      #以下近藤追記分
      if params[:product]!=nil
        if['jpg','png','jpeg'].include?(params[:product][:img].original_filename.split('.')[-1])
        file_name=Digest::SHA256.hexdigest(params[:product][:img].original_filename).to_s
        file_name+='.'+params[:product][:img].original_filename.split('.')[-1]
        
        upload_dir=Rails.root.join("public","product_img")
        upload_file_path=upload_dir+file_name
        #test_calc(upload_file_path)
        File.binwrite(upload_file_path,params[:product][:img].read)
      end
    end
      
      if file_name!=nil
        file_name='/product_img/'+file_name
      end
      #ここまで
      @product = Product.new(pid: params[:pid], seller_id: session[:seller],
      price: params[:price], description: params[:description], 
      img: file_name)#ここ改変
      @product.save
      redirect_to seller_index_path
    end
    
    def destroy
      product = Product.find(params[:id])
      product.destroy
      redirect_to seller_index_path
    end
    
    #近藤追記デバッグ用関数
    def test_calc(k)
        puts '-----------------------'
        puts k
        puts '-----------------------'
    end
end
