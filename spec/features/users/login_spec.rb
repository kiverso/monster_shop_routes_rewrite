require 'rails_helper'

RSpec.describe "user login/logout functionality" do
  context "as a visitor" do
    it "can login to profile with email and password" do
      
      user = create(:default_user)

      visit "/"

      click_link "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email,	with: "#{user.email}"
      fill_in :password,	with: "#{user.password}"

      click_button "Login"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are now logged in as #{user.name}")
    end

    it "must have valid email and password to login" do
      
      user = create(:default_user)

      visit "/"

      click_link "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email,	with: "#{user.email}"
      fill_in :password,	with: "Hamburglar"

      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Valid email and password required to login to your account!")
    end

    it "will redirect to user home page if already logged in" do
      
      user = create(:default_user)

      visit '/'

      click_link "Log In"

      fill_in :email,	with: "#{user.email}"
      fill_in :password,	with: "#{user.password}"

      click_button "Login"

      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You have already logged into your account!") 
    end

    it "can logout and empty cart" do

      user = create(:default_user)

      visit '/'

      click_link "Log In"

      fill_in :email,	with: "#{user.email}"
      fill_in :password,	with: "#{user.password}"

      click_button "Login"

      click_link "Log Out"

      expect(current_path).to eq("/")
      expect(page).to have_content("You have logged out of your account!")
      expect(page).to have_content("Cart: 0") 
    end
  end
end


# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in

# As a visitor
# When I visit the login page ("/login")
# And I submit invalid information
# Then I am redirected to the login page
# And I see a flash message that tells me that my credentials were incorrect
# I am NOT told whether it was my email or password that was incorrect

# As a registered user, merchant, or admin
# When I visit the login path
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that tells me I am already logged in

# As a registered user, merchant, or admin
# When I visit the logout path
# I am redirected to the welcome / home page of the site
# And I see a flash message that indicates I am logged out
# Any items I had in my shopping cart are deleted