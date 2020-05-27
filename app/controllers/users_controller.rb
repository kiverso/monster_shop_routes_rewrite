class UsersController < ApplicationController

  def new
    
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "You are now registered and logged in!"
      redirect_to profile_path
    else
      flash[:notice] = ""
    end
    
  end

  def show
    @user = User.find(params[:user_id])
  end
  
  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
  
end