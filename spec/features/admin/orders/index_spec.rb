require 'rails_helper'

RSpec.describe("Admin Order index page") do
  describe "When I go to the dashboard page with orders" do
    before(:each) do
      @user = create(:default_user)
      @admin = create(:admin)
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id, status: 'packaged')
      @order_2 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id, status: 'pending')
      @order_3 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id, status: 'shipped')
      @order_4 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id, status: 'cancelled')
      @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
      @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 3)
      @order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 3)
      @order_4.item_orders.create!(item: @tire, price: @tire.price, quantity: 3)
      visit "/"
      click_link "Log In"
      fill_in :email,	with: "#{@admin.email}"
      fill_in :password,	with: "#{@admin.password}"
      click_button "Login"
      visit admin_dashboard_path
    end
    it 'has each order information' do
      within(".order-#{@order_1.id}") do
        expect(page).to have_content("Order: #{@order_1.id}")
        expect(page).to have_link(@order_1.user.name)
        expect(page).to have_content(@order_1.created_at)
      end

      within(".order-#{@order_2.id}") do
        expect(page).to have_content("Order: #{@order_2.id}")
        expect(page).to have_link(@order_2.user.name)
        expect(page).to have_content(@order_2.created_at)
      end

      within(".order-#{@order_3.id}") do
        expect(page).to have_content("Order: #{@order_3.id}")
        expect(page).to have_link(@order_3.user.name)
        expect(page).to have_content(@order_3.created_at)
      end

      within(".order-#{@order_4.id}") do
        expect(page).to have_content("Order: #{@order_4.id}")
        expect(page).to have_link(@order_4.user.name)
        expect(page).to have_content(@order_4.created_at)
      end
      click_link 'Logout'
    end
  end
end