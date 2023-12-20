require 'bcrypt'
class UserController < ApplicationController
  def index
    @all_major=Major.all
  end
  
  def new
    @user = User.new
    render layout: "no_sidebar"
  end

  def create
    #create_pass = BCrypt::Password.create(params[:password])
    @user = User.new(uid: params[:uid], pass: params[:user][:pass],
    last_name: params[:last_name], name: params[:name], gender: params[:gender],
    address: params[:address], phone_number: params[:phone_number],
    birth: params[:birth],profile_id: nil, pass_confirmation: params[:pass_confirmation])
    if @user.save
        redirect_to root_path
    else
        render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to user_index_path
  end
  
  def login
    render layout: "no_sidebar"
  end
  
  def signin
    user = User.find_by(uid: params[:uid])
    if user && BCrypt::Password.new(user.password) == params[:password]
      session[:login_uid] = params[:uid]
      @users = User.all
      redirect_to root_path
    else
      render "login"
    end
    
  end
  
  def logout
    session.delete(:login_uid)
    redirect_to root_path
  end
end
