class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You are now registered and logged in!"
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end

  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(session[:user_id])
    if user_params[:password] != user_params[:password_confirmation] || !password_check?(user)
      flash[:error] = "Incorrect password."
      redirect_to action: :edit
    elsif user.update(user_params.except(:password, :password_confirmation))
      flash[:success] = "User profile updated!"
      redirect_to profile_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to action: :edit
    end
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def password_check?(user)
    BCrypt::Password.new(user.password_digest) == user_params[:password]
  end
end
