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
      @item_order1 = @order1.item_orders.create!(item: @item1, price: @item1.price, quantity: 2)
      @item_order2 = @order1.item_orders.create!(item: @item2, price: @item2.price, quantity: 2)
      # @item_order1 = create(:item_order, item_id: @item1.id, order_id: @order1.id)
      # @item_order2 = create(:item_order, item_id: @item2.id, order_id: @order1.id)
    end

    it "can see name and address of employee that I work for" do

      visit merchant_dashboard_path

      within ".contact" do
        expect(page).to have_content(@merchant.name) 
        expect(page).to have_content(@merchant.address) 
        expect(page).to have_content(@merchant.city) 
        expect(page).to have_content(@merchant.state) 
        expect(page).to have_content(@merchant.zip) 
      end
    end

    it "can see any pending orders" do

      visit merchant_dashboard_path

      within ".pending_order-#{@order1.id}" do
        expect(page).to have_link("Order: #{@order1.id}")
        expect(page).to have_content(@order1.created_at)
        expect(page).to have_content(@order1.item_count)
        expect(page).to have_content(@order1.grandtotal)
      end
    end

    it "has a link to merchant items index" do

      visit merchant_dashboard_path

      click_link "View Items"

      expect(current_path).to eq(merchant_items_path) 
    end
  end
end
