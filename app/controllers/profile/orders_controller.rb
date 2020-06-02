class Profile::OrdersController < Profile::BaseController
  def index
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.item_orders.each do |item_order|
      if item_order.status == 'fulfilled'
        new_inventory = item_order.item.inventory + item_order.quantity
        item_order.item.update_attribute(:inventory, new_inventory)
        item_order.update_attribute(:status, 'unfulfilled')
      end
    end
    order.update_attribute(:status, 'cancelled')
    flash[:success] = "Order #{order.id} has been cancelled."
    redirect_to profile_path
  end
end