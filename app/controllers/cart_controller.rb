class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    if cart.contents[item.id.to_s] && ((item.inventory - cart.contents[item.id.to_s]) < 1)
      flash[:error] = "Cannot add more of this item to the cart"
      redirect_to request.referrer
    else
      cart.add_item(item.id.to_s)
      flash[:success] = "#{item.name} was successfully added to your cart"
      if URI(request.referrer).path == "/cart"
        redirect_to "/cart"
      else
        redirect_to "/items"
      end
    end
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end


end
