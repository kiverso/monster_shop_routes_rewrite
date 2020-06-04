class Merchant::BaseController < ApplicationController
  before_action :require_merchant_employee
  
  def require_merchant_employee
    render file: "/public/404" unless current_merchant?
  end
end