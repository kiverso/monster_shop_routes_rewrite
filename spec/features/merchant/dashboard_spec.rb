require 'rails_helper'

RSpec.describe "merchant dashboard" do
  context "as a merchant employee" do
    before(:each) do
      @user = create(:default_user)
      @merchant = create(:merchant)
      @employee = create(:merchant_employee, merchant_id: @merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)
      @item1 = create(:item, merchant_id: @merchant.id)
      @item2 = create(:item, merchant_id: @merchant.id)
      @order1 = create(:order, user_id: @user.id)
      @item_order1 = create(:item_order, item_id: @item1.id, order_id: @order1.id)
      @item_order1 = create(:item_order, item_id: @item2.id, order_id: @order1.id)
    end

    it "can see name and address of employee that I work for" do

      visit merchant_path

      within ".contact" do
        expect(page).to have_content(@merchant.name) 
        expect(page).to have_content(@merchant.address) 
        expect(page).to have_content(@merchant.city) 
        expect(page).to have_content(@merchant.state) 
        expect(page).to have_content(@merchant.zip) 
      end
    end

    it "can see any pending orders" do
      
    end
    
  end
end
# As a merchant employee
# When I visit my merchant dashboard ("/merchant")
# If any users have pending orders containing items I sell
# Then I see a list of these orders.
# Each order listed includes the following information:
# - the ID of the order, which is a link to the order show page ("/merchant/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order