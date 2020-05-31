class PasswordsController < ApplicationController
  def edit

  end

  def update
    user = User.find(session[:user_id])
    if user.update(pw_params)
      flash[:success] = "Password updated!"
      redirect_to profile_path
    else
      flash[:error] = "Password confirmation field did not match"
      redirect_to action: :edit
    end
  end

  private
  def pw_params
    params.permit(:password, :password_confirmation)
  end
end
