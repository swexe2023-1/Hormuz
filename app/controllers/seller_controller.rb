require 'bcrypt'
class SellerController < ApplicationController
    def index
        @products = Product.where(seller_id: session[:seller])#近藤改変
        #test_calc(session[:seller])
        #render layout: "no_sidebar"
    end
  
    def new
        @seller = Seller.new
        #render layout: "no_sidebar"
    end

    def create
        #create_pass = BCrypt::Password.create(params[:password])
        @seller = Seller.new(sid: params[:sid], store_name: params[:store_name],
        pass: params[:seller][:pass], address: params[:address],
        phone: params[:phone].to_s, pass_confirmation: params[:pass_confirmation])
        if @seller.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def destroy
        #近藤追加
        if params[:seller_id]!=nil
            session[:seller]=params[:seller_id]
        end
        #ここまで
        
        seller = Seller.find(session[:seller])#近藤改変
        #近藤追加
        x=Product.where(seller_id: session[:seller])
        
        if x!=[]
            x.each do |k|
                y=Cart.where(product_id: k.id)
                t=Category.where(product_id: k.id)
                if t!=[]
                    t.destroy_all
                end
                
                if y!=[]
                    y.destroy_all
                end
            end
            x.destroy_all
        end
        
        session[:seller]=nil
        #ここまで
        seller.destroy
        redirect_to root_path
    end
      
    def login
        #render layout: "no_sidebar"
    end
      
    def signin
        seller = Seller.find_by(sid: params[:sid])
        if seller && BCrypt::Password.new(seller.password) == params[:password]
          session[:login_sid] = params[:sid]
          #近藤追記
          session[:seller]=seller.id
          session[:login_user_id]=nil
          session[:admin_id]=nil
          #ここまで
          @sellers = Seller.all
          redirect_to seller_index_path
        else
          render "login"
        end
    end
      
    def logout
        session.delete(:login_sid)
        session[:seller]=nil#近藤追記
        redirect_to root_path
    end
    
    #近藤追記
    def set_keyword
        #test_calc(params[:kw]=='')
        if params[:kw]!='' && params[:kw]!=nil
            Category.create(product_id: params[:product_id],key_word: params[:kw])
        end
        params[:kw]=nil
        params[:product]=nil
        redirect_to seller_index_path
    end
    
    #近藤追記デバッグ用関数
    def test_calc(k)
        puts '-----------------------'
        puts k
        puts '-----------------------'
    end
end
