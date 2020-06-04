class Item <ApplicationRecord
  before_save :default_image
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, greater_than_or_equal_to: 0, only_integer: true

  def self.sort_popularity(limit, order)
    Item.select("items.*, sum(quantity) as qty_ordered").joins(:item_orders).group(:id).order("qty_ordered #{order}").limit(limit)
  end

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def qty_ordered
    item_orders.sum(:quantity)
  end

  def default_image
    if self.image == ""
      self.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/200px-No_image_available_600_x_450.svg.png"
    end
  end

end
