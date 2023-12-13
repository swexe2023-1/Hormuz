require 'bcrypt'
class AdminController < ApplicationController
    def index
        render layout: "no_sidebar"
    end
  
    def new
        @admin = Admin.new
    end

    def create
        #create_pass = BCrypt::Password.create(params[:password])
        @admin = Admin.new(aid: params[:aid], pass: params[:seller][:pass])
        if @admin.save
            redirect_to root_path
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
          redirect_to root_path
        else
          render "login"
        end
    end
      
    def logout
        session.delete(:login_aid)
        redirect_to root_path
    end
end
