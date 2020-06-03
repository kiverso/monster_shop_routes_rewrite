require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    end

    it 'I can see a list of merchants in the system' do
      visit '/merchants'

      expect(page).to have_link("Brian's Bike Shop")
      expect(page).to have_link("Meg's Dog Shop")
    end

    it 'I can see a link to create a new merchant' do
      visit '/merchants'

      expect(page).to have_link("New Merchant")

      click_on "New Merchant"

      expect(current_path).to eq("/merchants/new")
    end
  end

  describe 'As an admin' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
      admin = create(:admin)
      visit "/"
      click_link "Log In"

      fill_in :email,	with: "#{admin.email}"
      fill_in :password,	with: "#{admin.password}"

      click_button "Login"
    end

    it "shows admins all merchants along with their info" do
      @bike_shop.update_attribute(:active?, false)
      visit admin_merchants_path

      within ".merchant-#{@bike_shop.id}" do
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
        expect(page).to have_link(@bike_shop.name)
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_content(@bike_shop.state)
      end

      within ".merchant-#{@dog_shop.id}" do
        expect(page).to_not have_button("Enable")
        expect(page).to have_button("Disable")
        expect(page).to have_content(@dog_shop.city)
        expect(page).to have_content(@dog_shop.state)
        click_link(@dog_shop.name)
      end

      expect(current_path).to eq(admin_merchant_path(@dog_shop.id))
    end

  end
end
