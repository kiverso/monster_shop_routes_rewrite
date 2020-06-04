require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    end

    it 'I can delete an item' do
      visit "/items/#{@chain.id}"

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect("item-#{@chain.id}").to be_present
    end

    it 'I can delete items and it deletes reviews' do
      review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)

      visit "/items/#{@chain.id}"

      click_on "Delete Item"
      expect(Review.where(id:review_1.id)).to be_empty
    end

    it 'I can not delete items with orders' do
      user = create(:default_user)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user_id: user.id)
      order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)

      visit "/items/#{@chain.id}"

      expect(page).to_not have_link("Delete Item")
    end

    it 'I can delete items as a merchant, so long as it has never been ordered' do
      new_item = create(:item, merchant_id: @bike_shop.id)
      order = create(:order)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)

      employee = create(:merchant_employee, merchant_id: @bike_shop.id)
      visit "/"
      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"
      visit merchant_items_path

      within "#item-#{@chain.id}" do
        expect(page).to_not have_button("Delete")
      end

      within "#item-#{new_item.id}" do
        click_button "Delete"
      end

      expect(current_path).to eq(merchant_items_path)
      expect(page).to have_content("#{new_item.name} is now deleted")
      expect(page).to_not have_content(new_item.description)
      expect(page).to_not have_content(new_item.image)
    end
  end
end
