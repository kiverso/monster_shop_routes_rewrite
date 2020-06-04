class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_count
    item_orders.sum(:quantity)
  end

  def items_from_merchant(merchant_id)
     item_orders.joins(:item).where(items: {merchant_id: merchant_id})
  end
end
