class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.order("CASE status WHEN 'packaged' THEN 0 WHEN 'pending' 
    THEN 1 WHEN 'shipped' THEN 2 WHEN 'cancelled' THEN 3 ELSE 4 END")
  end
end