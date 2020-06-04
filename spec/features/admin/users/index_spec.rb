require 'rails_helper'

RSpec.describe "admin users index page" do
  context "as an admin" do
    before(:each) do
      @user1 = create(:default_user)
      @user2 = create(:default_user)
      @merchant = create(:merchant)
      @employee1 = create(:merchant_employee, merchant_id: @merchant.id)
      @employee2 = create(:merchant_employee, merchant_id: @merchant.id)
      @admin1 = create(:admin)
      @admin2 = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end

    it "can see all users with their names as links to their show page, created at and role" do
      
      visit admin_dashboard_path
# binding.pry
      within 'nav' do
        click_link "Users"
      end

      expect(current_path).to eq(admin_users_path)

      within ".user-#{@user1.id}" do
        expect(page).to have_link(@user1.name) 
        expect(page).to have_content("User Role: #{@user1.role}") 
        expect(page).to have_content("Created On: #{@user1.created_at}") 
      end

      within ".user-#{@user2.id}" do
        expect(page).to have_link(@user2.name) 
        expect(page).to have_content("User Role: #{@user2.role}") 
        expect(page).to have_content("Created On: #{@user2.created_at}") 
      end

      within ".user-#{@employee1.id}" do
        expect(page).to have_link(@employee1.name) 
        expect(page).to have_content("User Role: #{@employee1.role}") 
        expect(page).to have_content("Created On: #{@employee1.created_at}") 
      end

      within ".user-#{@employee2.id}" do
        expect(page).to have_link(@employee2.name) 
        expect(page).to have_content("User Role: #{@employee2.role}") 
        expect(page).to have_content("Created On: #{@employee2.created_at}") 
      end
      
      within ".user-#{@admin1.id}" do
        expect(page).to have_link(@admin1.name) 
        expect(page).to have_content("User Role: #{@admin1.role}") 
        expect(page).to have_content("Created On: #{@admin1.created_at}") 
      end

      within ".user-#{@admin2.id}" do
        expect(page).to have_link(@admin2.name) 
        expect(page).to have_content("User Role: #{@admin2.role}") 
        expect(page).to have_content("Created On: #{@admin2.created_at}") 
      end
    end
  end
end
# As an admin user
# When I click the "Users" link in the nav (only visible to admins)
# Then my current URI route is "/admin/users"
# Only admin users can reach this path.
# I see all users in the system
# Each user's name is a link to a show page for that user ("/admin/users/5")
# Next to each user's name is the date they registered
# Next to each user's name I see what type of user they are