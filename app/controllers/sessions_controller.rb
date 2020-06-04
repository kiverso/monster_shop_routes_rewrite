class SessionsController < ApplicationController
  def new
    unless current_user.nil?
      login_redirect
      flash[:error] = "You have already logged into your account!"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in as #{user.name}"
      login_redirect
    else
      flash[:error] = "Valid email and password required to login to your account!"
      render :new
    end
  end

  def destroy
    session.delete(:cart)
    session.delete(:user_id)
    flash[:success] = "You have logged out of your account!"
    redirect_to "/"
  end
  

  private

  def login_redirect
    redirect_to profile_path if current_default?
    redirect_to merchant_dashboard_path if current_merchant?
    redirect_to admin_dashboard_path if current_admin
  end
  
  
end