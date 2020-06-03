class Merchant::ItemOrdersController < Merchant::BaseController
  def update
    item_order = ItemOrder.find(params[:id])
    if item_order.quantity <= item_order.item.inventory
      item_order.update(status: 'fulfilled')
      new_inventory = item_order.item.inventory - item_order.quantity
      item_order.item.update(inventory: new_inventory)
      flash[:success] = "#{item_order.item.name} has been fulfilled"
      if item_order.order.item_orders.all? {|item| item.status == 'fulfilled'}
        item_order.order.update(status: 'packaged')
      end
      redirect_to merchant_order_path(item_order.order.id)
    end

  end
end

