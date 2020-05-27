require 'rails_helper'

RSpec.describe "new user registration page" do
  context "as a visitor" do
    before(:each) do
      @user1 = (name: "Rick Sanchez",
                address: "123 Street",
                city: "Denver",
                state: "CO",
                zip: "80202",
                email: "PickleRick@example.com",
                password: "GetSchwifty1")
    end

    it "can fill out a form to create a new regular user" do
      
      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq("/register") 

      fill_in :name,	with: @user1.name 
      fill_in :address,	with: @user1.address 
      fill_in :city,	with: @user1.city 
      fill_in :state,	with: @user1.state 
      fill_in :zip,	with: @user1.zip 
      fill_in :email,	with: @user1.email 
      fill_in :password,	with: @user1.password 
      fill_in :password_confirmation,	with: @user1.password
      click_button "Submit"

      expect(current_path).to eq("/profile") 
      expect(page).to have_content("Welcome #{@user1.name}, you are now registered and logged in!") 
    end
  end
end

