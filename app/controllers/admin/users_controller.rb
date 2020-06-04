class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def method_name
    
  end
  
  
end