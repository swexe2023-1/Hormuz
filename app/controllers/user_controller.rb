class UserController < ApplicationController
  def index
    render 'user_login'
  end

  def new
    @user = User.new
  end

  def create
    #pass = BCrypt::Password.create(params[:password])
    @user = User.new(uid: params[:uid], pass: params[:user][:pass],
    last_name: params[:last_name], name: params[:name], gender: params[:gender],
    address: params[:address], phone_number: params[:phone_number],
    birth: params[:birth],profile_id: nil, pass_confirmation: params[:pass_confirmation])
    if @user.save
        redirect_to users_path
    else
        render 'user_new'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end
end
