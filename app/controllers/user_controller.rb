require 'bcrypt'
class UserController < ApplicationController
  def index
    @all_major=Major.all
  end
  
  def new
    @user = User.new
    #render layout: "no_sidebar"
  end

  def create
    create_pass=nil
    if params[:user][:pass]==params[:user][:pass_confirmation]
      if User.find_by(uid: params[:uid])==nil
        create_pass=params[:user][:pass]
      end
    end
    
    @user = User.new(uid: params[:uid], pass: create_pass,
    last_name: params[:last_name], name: params[:name], gender: params[:gender],
    address: params[:address], phone_number: params[:phone_number],
    birth: params[:birth],profile_id: nil)
    
    if create_pass!=nil
      if @user.save
        redirect_to root_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(session[:login_user_id])
    #近藤追加
    c=Cart.where(user_id: session[:login_user_id])
    d=Purchased.where(user_id: session[:login_user_id])
    if c!=[]
      c.destroy_all
    end
    
    if d!=[]
      d.destroy_all
    end
    session[:login_user_id]=nil
    #ここまで
    
    user.destroy
    redirect_to user_index_path
  end
  
  def login
    #render layout: "no_sidebar"
  end
  
  def signin
    session[:seller]=nil#近藤追記
    user = User.find_by(uid: params[:uid])
    if user && BCrypt::Password.new(user.password) == params[:password]
      session[:login_uid] = params[:uid]
      #近藤追記
      session[:seller]=nil
      session[:login_user_id]=user.id
      session[:admin_id]=nil
      #ここまで
      
      @users = User.all
      redirect_to root_path
    else
      render "login"
    end
    
  end
  
  def logout
    session.delete(:login_uid)
    session[:login_user_id]=nil#近藤追記
    redirect_to root_path
  end
  
  #近藤追記デバッグ用関数
    def test_calc(k)
        puts '-----------------------'
        puts k
        puts '-----------------------'
    end
end
