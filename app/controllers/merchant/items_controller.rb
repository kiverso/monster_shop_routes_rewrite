class Merchant::ItemsController < ApplicationController
  before_action :require_merchant_employee
  
  def index
    @items = current_user.merchant.items
  end
  
end