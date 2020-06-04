require 'rails_helper'

RSpec.describe "Create Merchant Items" do
  describe "When I visit the merchant items index page" do
    before(:each) do
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    end

    it 'I see a link to add a new item for that merchant' do
      visit "/merchants/#{@brian.id}/items"

      expect(page).to have_link "Add New Item"
    end

    it 'I can add a new item by filling out a form' do
      visit "/merchants/#{@brian.id}/items"

      name = "Chamois Buttr"
      price = 18
      description = "No more chaffin'!"
      image_url = "https://images-na.ssl-images-amazon.com/images/I/51HMpDXItgL._SX569_.jpg"
      inventory = 25

      click_on "Add New Item"

      expect(page).to have_link(@brian.name)
      expect(current_path).to eq("/merchants/#{@brian.id}/items/new")
      fill_in :name, with: name
      fill_in :price, with: price
      fill_in :description, with: description
      fill_in :image, with: image_url
      fill_in :inventory, with: inventory

      click_button "Create Item"

      new_item = Item.last

      expect(current_path).to eq("/merchants/#{@brian.id}/items")
      expect(new_item.name).to eq(name)
      expect(new_item.price).to eq(price)
      expect(new_item.description).to eq(description)
      expect(new_item.image).to eq(image_url)
      expect(new_item.inventory).to eq(inventory)
      expect(Item.last.active?).to be(true)
      expect("#item-#{Item.last.id}").to be_present
      expect(page).to have_content(name)
      expect(page).to have_content("Price: $#{new_item.price}")
      expect(page).to have_css("img[src*='#{new_item.image}']")
      expect(page).to have_content("Active")
      expect(page).to_not have_content(new_item.description)
      expect(page).to have_content("Inventory: #{new_item.inventory}")
    end

    it 'I get an alert if I dont fully fill out the form' do
      visit "/merchants/#{@brian.id}/items"

      name = ""
      price = 18
      description = "No more chaffin'!"
      image_url = "https://images-na.ssl-images-amazon.com/images/I/51HMpDXItgL._SX569_.jpg"
      inventory = ""

      click_on "Add New Item"

      fill_in :name, with: name
      fill_in :price, with: price
      fill_in :description, with: description
      fill_in :image, with: image_url
      fill_in :inventory, with: inventory

      click_button "Create Item"

      expect(page).to have_content("Name can't be blank, Inventory can't be blank")
      expect(page).to have_button("Create Item")
    end

    it 'can have a merchant create an item' do
      new_item = create(:item, merchant_id: @brian.id)
      new_item.destroy

      employee = create(:merchant_employee, merchant_id: @brian.id)
      visit "/"
      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"
      visit merchant_items_path

      click_link "Add New Item"
      expect(current_path).to eq(new_merchant_item_path)

      fill_in :name, with: new_item.name
      fill_in :price, with: new_item.price
      fill_in :description, with: new_item.description
      fill_in :inventory, with: new_item.inventory

      click_button "Create Item"

      test_item = Item.last
      expect(current_path).to eq(merchant_items_path)
      expect(page).to have_content("#{new_item.name} is saved")
      within "#item-#{test_item.id}" do
        expect(page).to have_content(new_item.name)
        expect(page).to have_content("Price: $#{new_item.price}")
        expect(page).to have_css("img[src*='#{test_item.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(new_item.description)
        expect(page).to have_content("Inventory: #{new_item.inventory}")
      end
    end

    it "sends an error message when given incorrect or incomplete data" do
      new_item = create(:item, merchant_id: @brian.id)
      new_item.destroy

      employee = create(:merchant_employee, merchant_id: @brian.id)
      visit "/"
      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"
      visit merchant_items_path

      click_link "Add New Item"
      expect(current_path).to eq(new_merchant_item_path)

      fill_in :description, with: new_item.description
      fill_in :price, with: "0"
      fill_in :inventory, with: "2.50"

      click_button "Create Item"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Price must be greater than 0")
      expect(page).to have_content("Inventory must be an integer")
      expect(find_field(:description).value).to eq(new_item.description)
      expect(find_field(:price).value).to eq("0")
      expect(find_field(:inventory).value).to eq("2.50")
    end
  end
end
