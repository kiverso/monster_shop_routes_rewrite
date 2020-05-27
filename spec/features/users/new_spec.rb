require 'rails_helper'

RSpec.describe "new user registration page" do
  context "as a visitor" do
    before(:each) do
      @user1 = { name: "Rick Sanchez",
                address: "123 Street",
                city: "Denver",
                state: "CO",
                zip: "80202",
                email: "PickleRick@example.com",
                password: "GetSchwifty1",
                role: 0} 
      @user2 = { name: "Morty Smith",
                address: "321 Street",
                city: "Aurora",
                state: "CO",
                zip: "80000",
                email: "FluDance@example.com",
                password: "Jessica2",
                role: 0} 
    end

    it "can fill out a form to create a new regular user" do

      visit merchants_path
      
      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq("/register") 

      fill_in :name,	with: @user1[:name]
      fill_in :address,	with: @user1[:address]
      fill_in :city,	with: @user1[:city] 
      fill_in :state,	with: @user1[:state] 
      fill_in :zip,	with: @user1[:zip] 
      fill_in :email,	with: @user1[:email]
      fill_in :password,	with: @user1[:password]
      fill_in :password_confirmation,	with: @user1[:password]
      click_button "Submit"

      expect(current_path).to eq("/profile") 
      expect(page).to have_content("Welcome Rick Sanchez!")
      expect(page).to have_content("You are now registered and logged in!") 
    end

    xit "cannot register with missing fields" do

      visit merchants_path
      
      within 'nav' do
        click_link 'Register'
      end

      fill_in :name,	with: @user1[:name] 
      fill_in :address,	with: @user1[:address]
      fill_in :city,	with: @user1[:city]
      # fill_in :state,	with: @user1.state 
      fill_in :zip,	with: @user1[:zip] 
      fill_in :email,	with: @user1[:email] 
      fill_in :password,	with: @user1[:password]
      fill_in :password_confirmation,	with: @user1[:password]
      click_button "Submit"

      expect(current_path).to eq("/register") 
      expect(page).to have_content("State can't be blank") 
    end

    xit "must have unique email address" do

      visit merchants_path

      
      within 'nav' do
        click_link 'Register'
      end

      fill_in :name,	with: @user1[:name]
      fill_in :address,	with: @user1[:address]
      fill_in :city,	with: @user1[:city] 
      fill_in :state,	with: @user1[:state] 
      fill_in :zip,	with: @user1[:zip] 
      fill_in :email,	with: @user1[:email]
      fill_in :password,	with: @user1[:password]
      fill_in :password_confirmation,	with: @user1[:password]
      click_button "Submit"


      within 'nav' do
        click_link 'Register'
      end

      fill_in :name,	with: @user2[:name]
      fill_in :address,	with: @user2[:address]
      fill_in :city,	with: @user2[:city] 
      fill_in :state,	with: @user2[:state] 
      fill_in :zip,	with: @user2[:zip]
      fill_in :email,	with: @user1[:email]
      fill_in :password,	with: @user2[:password] 
      fill_in :password_confirmation,	with: @user2[:password]
      click_button "Submit"


      expect(current_path).to eq("/register") 
      expect(page).to have_content("The email address entered is already in use, please select another") 
      expect(page).to have_content("Morty Smith") 
      expect(page).to have_content("123 Street") 
      expect(page).to have_content("CO") 
      expect(page).to have_content("80202") 
    end
  end
end

