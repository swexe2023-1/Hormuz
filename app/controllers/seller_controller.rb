require 'bcrypt'
class SellerController < ApplicationController
    def index
        @products = Product.all
        render layout: "no_sidebar"
    end
  
    def new
        @seller = Seller.new
        render layout: "no_sidebar"
    end

    def create
        #create_pass = BCrypt::Password.create(params[:password])
        @seller = Seller.new(sid: params[:sid], store_name: params[:store_name],
        pass: params[:seller][:pass], address: params[:address],
        phone: params[:phone], pass_confirmation: params[:pass_confirmation])
        if @seller.save
            redirect_to admin_index_path
        else
            render 'new'
        end
    end

    def destroy
        seller = Seller.find(params[:id])
        seller.destroy
        redirect_to root_path
    end
      
    def login
        render layout: "no_sidebar"
    end
      
    def signin
        seller = Seller.find_by(sid: params[:sid])
        if seller && BCrypt::Password.new(seller.password) == params[:password]
          session[:login_sid] = params[:sid]
          @sellers = Seller.all
          redirect_to seller_index_path
        else
          render "login"
        end
    end
      
    def logout
        session.delete(:login_sid)
        redirect_to root_path
    end
end
