require 'rails_helper'

RSpec.describe "Merchant Items Index Page" do
  describe "When I visit the merchant items page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
    end

    it 'shows me a list of that merchants items' do
      visit "merchants/#{@meg.id}/items"

      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content("Active")
        expect(page).to_not have_content(@tire.description)
        expect(page).to have_content("Inventory: #{@tire.inventory}")
      end

      within "#item-#{@chain.id}" do
        expect(page).to have_content(@chain.name)
        expect(page).to have_content("Price: $#{@chain.price}")
        expect(page).to have_css("img[src*='#{@chain.image}']")
        expect(page).to have_content("Active")
        expect(page).to_not have_content(@chain.description)
        expect(page).to have_content("Inventory: #{@chain.inventory}")
      end

      within "#item-#{@shifter.id}" do
        expect(page).to have_content(@shifter.name)
        expect(page).to have_content("Price: $#{@shifter.price}")
        expect(page).to have_css("img[src*='#{@shifter.image}']")
        expect(page).to have_content("Inactive")
        expect(page).to_not have_content(@shifter.description)
        expect(page).to have_content("Inventory: #{@shifter.inventory}")
      end
    end

    it "can deactivate an item as a merchant employee" do
      employee = create(:merchant_employee)
      employee.update_attribute(:merchant_id, @meg.id)
      visit "/"
      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"
      visit merchant_items_path

      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_button "Deactivate"
        expect(page).to_not have_button "Activate"
      end

      within "#item-#{@shifter.id}" do
        expect(page).to have_content(@shifter.name)
        expect(page).to have_content("Price: $#{@shifter.price}")
        expect(page).to have_css("img[src*='#{@shifter.image}']")
        expect(page).to have_content("Inactive")
        expect(page).to have_content(@shifter.description)
        expect(page).to have_content("Inventory: #{@shifter.inventory}")
        expect(page).to_not have_button "Deactivate"
        expect(page).to have_button "Activate"
      end

      within "#item-#{@chain.id}" do
        expect(page).to have_content(@chain.name)
        expect(page).to have_content("Price: $#{@chain.price}")
        expect(page).to have_css("img[src*='#{@chain.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(@chain.description)
        expect(page).to have_content("Inventory: #{@chain.inventory}")
        expect(page).to_not have_button "Activate"
        click_button "Deactivate"
      end

      expect(current_path).to eq(merchant_items_path)
      expect(page).to have_content("#{@chain.name} is no longer for sale")
      within "#item-#{@chain.id}" do
        expect(page).to have_button "Activate"
        expect(page).to_not have_button "Deactivate"
        expect(page).to have_content("Inactive")
      end
    end

    it "can reactivate an item as a merchant employee" do
      employee = create(:merchant_employee)
      employee.update_attribute(:merchant_id, @meg.id)
      visit "/"
      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"
      visit merchant_items_path

      within "#item-#{@shifter.id}" do
        click_button "Activate"
      end

      expect(current_path).to eq(merchant_items_path)
      expect(page).to have_content("#{@shifter.name} is now available for sale")
      within "#item-#{@shifter.id}" do
        expect(page).to have_button "Deactivate"
        expect(page).to_not have_button "Activate"
        expect(page).to have_content("Active")
      end
    end

  end
end
