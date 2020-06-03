class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.enable_all_items
    merchant.update_attribute(:active?, true)
    flash[:notice] = "#{merchant.name} is now enabled"
    redirect_to admin_merchants_path
  end

  def destroy
    merchant = Merchant.find(params[:id])
    merchant.disable_all_items
    merchant.update_attribute(:active?, false)
    flash[:notice] = "#{merchant.name} is now disabled"
    redirect_to admin_merchants_path
  end
end
