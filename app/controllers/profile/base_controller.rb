class Profile::BaseController < ApplicationController
  def require_registered_user
    render file: "/public/404" unless current_user
  end
end