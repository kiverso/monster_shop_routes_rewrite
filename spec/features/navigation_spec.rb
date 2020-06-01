
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit merchants_path

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq(items_path)

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq(merchants_path)

      within 'nav' do
        click_link 'Home'
      end

      expect(current_path).to eq('/')

      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq(register_path)

      within 'nav' do
        click_link 'Log In'
      end

      expect(current_path).to eq(login_path)
    end

    it "I can see a cart indicator on all pages" do
      visit merchants_path

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit items_path

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

    end
  end

  describe 'As a Registered user' do
    it "I see a nav bar with links to all pages" do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      visit merchants_path

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq(items_path)

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq(merchants_path)

      within 'nav' do
        click_link 'Home'
      end

      expect(current_path).to eq('/')

      within 'nav' do
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Log In')
        expect(page).to_not have_link('Merchant Dashboard', href: merchant_dashboard_path)
        expect(page).to_not have_link('Admin Dashboard')
        expect(page).to_not have_link('All Users')
        expect(page).to have_link('Log Out')
      end

      within 'nav' do
        expect(page).to have_link('My Profile')
      end

      within 'nav' do
        expect(page).to have_content("Logged in as #{user1.name}")
      end
    end

    it "I can see a cart indicator on all pages" do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit merchants_path

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit items_path

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
  end

  describe 'As a merchant user' do
    it "I see a nav bar with links to all pages" do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      visit merchants_path

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq(items_path)

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq(merchants_path)

      within 'nav' do
        click_link 'Home'
      end

      expect(current_path).to eq('/')

      within 'nav' do
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Log In')
        expect(page).to_not have_link('Admin Dashboard')
        expect(page).to_not have_link('All Users')

        expect(page).to have_link('Log Out')
      end

      within 'nav' do
        expect(page).to have_link('My Profile')
      end

      within 'nav' do
        expect(page).to have_content("Logged in as #{user1.name}")
      end

      within 'nav' do
        expect(page).to have_link('Merchant Dashboard', href: merchant_dashboard_path)
      end
    end

    it "I can see a cart indicator on all pages" do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit merchants_path

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit items_path

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
  end

  describe 'As an admin user' do
    it "I see a nav bar with links to all pages" do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      visit merchants_path

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq(items_path)

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq(merchants_path)

      within 'nav' do
        click_link 'Home'
      end

      expect(current_path).to eq('/')

      within 'nav' do
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Log In')
        expect(page).to have_link('Log Out')
      end

      within 'nav' do
        expect(page).to have_link('My Profile')
      end

      within 'nav' do
        expect(page).to have_content("Logged in as #{user1.name}")
      end

      within 'nav' do
        expect(page).to have_link('Admin Dashboard')
        expect(page).to have_link('All Users')
      end
    end

    it "I can not see a cart indicator" do
      user2 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      visit merchants_path

      within 'nav' do
        expect(page).to_not have_content("Cart:")
      end

      visit items_path

      within 'nav' do
        expect(page).to_not have_content("Cart:")
      end
    end
  end
end
