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

  context "as a merchant employee" do
    it "can log into merchant dashboard" do

      employee = create(:merchant_employee)

      visit "/"

      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"

      expect(current_path).to eq(merchant_dashboard_path) 
      expect(page).to have_content("You are now logged in as #{employee.name}")
    end

    it "will redirect to merchant dashboard if already logged in" do
      
      employee = create(:merchant_employee)

      visit '/'

      click_link "Log In"

      fill_in :email,	with: "#{employee.email}"
      fill_in :password,	with: "#{employee.password}"

      click_button "Login"

      visit login_path

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("You have already logged into your account!") 
    end
    
  end

  context "as an admin" do
    it "can log into admin dashboard" do

      admin = create(:admin)

      visit "/"

      click_link "Log In"

      fill_in :email,	with: "#{admin.email}"
      fill_in :password,	with: "#{admin.password}"

      click_button "Login"

      expect(current_path).to eq("/admin") 
      expect(page).to have_content("You are now logged in as #{admin.name}")
    end

    it "will redirect to admin dashboard if already logged in" do
      
      admin = create(:admin)

      visit '/'

      click_link "Log In"

      fill_in :email,	with: "#{admin.email}"
      fill_in :password,	with: "#{admin.password}"

      click_button "Login"

      visit login_path

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("You have already logged into your account!") 
    end
  end
end

