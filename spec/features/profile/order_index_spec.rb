require 'rails_helper'

RSpec.describe("User Order index page") do
  describe "When I go to the index page with orders" do
    before(:each) do
      @user = create(:default_user)
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_2 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
      @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 3)
      visit "/"
      click_link "Log In"
      fill_in :email,	with: "#{@user.email}"
      fill_in :password,	with: "#{@user.password}"
      click_button "Login"
      visit profile_orders_path
      save_and_open_page
    end
    it 'has all order information' do
      within(".order-#{@order_1.id}") do
        expect(page).to have_link("Order: #{@order_1.id}")
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content("Last Updated:")
        expect(page).to have_content(@order_1.status)
        expect(page).to have_content(@order_1.grandtotal)
        expect(page).to have_content(@order_1.item_count)
      end
    end
  end
end