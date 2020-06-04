class OrdersController <ApplicationController

  before_action :require_registered_user

  def new

  end

  def create
    params[:user_id] = current_user.id
    order = Order.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:success] = "Your order was created successfully"
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip, :user_id)
  end

  def require_registered_user
    render file: "shared/require_login" unless current_user
  end
end
