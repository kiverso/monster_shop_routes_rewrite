require 'rails_helper'

RSpec.describe "admin users profile page" do
  context "as an admin" do
    before(:each) do
      @user1 = create(:default_user)
      @merchant = create(:merchant)
      @employee1 = create(:merchant_employee, merchant_id: @merchant.id)
      @admin1 = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end

    it "can see the same info a user would see except a link to edit their proifile" do
      
      visit admin_dashboard_path

      within 'nav' do
        click_link "Users"
      end
      
      click_link(@user1.name)

      expect(current_path).to eq(admin_user_path(@user1)) 

      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user1.address)
      expect(page).to have_content(@user1.city)
      expect(page).to have_content(@user1.state)
      expect(page).to have_content(@user1.zip)
      expect(page).to have_content(@user1.email)

      expect(page).to have_no_link("Edit Profile") 

      visit admin_dashboard_path

      within 'nav' do
        click_link "Users"
      end
      
      click_link(@employee1.name)

      expect(current_path).to eq(admin_user_path(@employee1)) 

      expect(page).to have_content(@employee1.name)
      expect(page).to have_content(@employee1.address)
      expect(page).to have_content(@employee1.city)
      expect(page).to have_content(@employee1.state)
      expect(page).to have_content(@employee1.zip)
      expect(page).to have_content(@employee1.email)

      expect(page).to have_no_link("Edit Profile") 
    end
  end
end
