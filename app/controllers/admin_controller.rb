require 'bcrypt'
class AdminController < ApplicationController
    def index
        @sellers = Seller.all
        #render layout: "no_sidebar"
    end
  
    def new
        @admin = Admin.new
        #render layout: "no_sidebar"
    end

    def create
        #create_pass = BCrypt::Password.create(params[:password])
        @admin = Admin.new(aid: params[:aid], pass: params[:admin][:pass])
        if @admin.save
            redirect_to admin_index_path
        else
            render 'new'
        end
    end

    def destroy
        admin = Admin.find(params[:id])
        admin.destroy
        redirect_to root_path
    end
      
    def signin
        admin = Admin.find_by(aid: params[:aid])
        if admin && BCrypt::Password.new(admin.password) == params[:password]
          session[:login_aid] = params[:aid]
          @admin = Admin.all
          session[:seller]=nil
          session[:login_user_id]=nil
          session[:admin_id]=admin.id
          redirect_to admin_index_path
        else
          render "index"
        end
    end
      
    def logout
        session.delete(:login_aid)
        redirect_to admin_index_path
    end
end
