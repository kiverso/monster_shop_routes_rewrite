require 'rails_helper'

RSpec.describe("Merchant Order Fulfillment") do
  describe "When I go to the show page with an order" do
    before(:each) do
      @user = create(:default_user)
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @merchant = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 1,
                          merchant_id: @meg.id)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_2 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_3 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 14)
      visit "/"
      click_link "Log In"
      fill_in :email,	with: "#{@merchant.email}"
      fill_in :password,	with: "#{@merchant.password}"
      click_button "Login"
    end

    it 'has button to fulfill the item' do
      visit item_path(@tire.id)
      expect(page).to have_content("Inventory: 12")
      visit merchant_order_path(@order_1.id)
      within "#item-#{@tire.id}" do
        expect(page).to have_content("unfulfilled")
        expect(page).to have_button('Fulfill')
        click_button 'Fulfill'
        expect(page).to_not have_button('Fulfill')
        expect(page).to have_content('Item has already been fulfilled')
      end
      expect(page).to have_content("#{@tire.name} has been fulfilled")

      visit item_path(@tire.id)
      expect(page).to have_content("Inventory: 10")
    end

    it 'will not be able to fulfill if there is not enough inventory' do
      visit merchant_order_path(@order_3.id)
      expect(page).to_not have_button('Fulfill')
      expect(page).to have_content('Item cannot be fulfilled')
    end
  end
end