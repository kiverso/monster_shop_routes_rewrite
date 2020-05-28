class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in as #{user.name}"
      # login_redirect
      redirect_to "/profile"
    end
  end

  private

  # def login_redirect
  #   redirect_to profile_path if current_default?
  # end
  
  
end