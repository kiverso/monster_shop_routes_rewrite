class UsersController < ApplicationController

  def new
    
  end

  def create
    redirect_to profile_path
  end

  def show
    @user = User.find(params[:user_id])
  end
  
  
  
end