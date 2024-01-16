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
          
          upload_dir=Rails.root.join("public")
          upload_file_path=upload_dir+file_name
          #test_calc(upload_file_path)
          File.binwrite(upload_file_path,params[:product][:img].read)
        end
      end
      
      if file_name!=nil
        file_name='/'+file_name
      end
      #ここまで
      @product = Product.new(pid: params[:pid], seller_id: session[:seller],
      price: params[:price], description: params[:description], 
      img: file_name)#ここ改変
      @product.save
      redirect_to seller_index_path
    end
    
    def edit
      test_calc(params[:p_id])
      @p_id=params[:p_id]
      @product = Product.find(params[:p_id])
    end
    
    def pd_edit
      x=Product.find(params[:p_id])
      check_set(params[:pid],x.pid)
      check_set(params[:price],x.price)
      check_set(params[:description],x.description)
      
      if params[:product]!=nil
        if['jpg','png','jpeg'].include?(params[:product][:img].original_filename.split('.')[-1])
          file_name=Digest::SHA256.hexdigest(params[:product][:img].original_filename).to_s
          file_name+='.'+params[:product][:img].original_filename.split('.')[-1]
          
          upload_dir=Rails.root.join("public")
          upload_file_path=upload_dir+file_name
          #test_calc(upload_file_path)
          File.binwrite(upload_file_path,params[:product][:img].read)
        end
      
      x.img='/'+file_name
      x.save
      redirect_to seller_index_path
      else
        render 'edit'
      end
    end
    
    def check_set(a,b)
      if a!=nil && a!=''
        b=a
      end
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
