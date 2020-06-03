require 'rails_helper'

RSpec.describe "navigation restrictions" do
  context "as a visitor" do
    it "will return 404 error for any merchant/admin/profile routes" do
      visit merchant_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")

      # visit '/admin'

      # expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as a default user" do
    it "will return 404 on merchant/admin routes" do
      user = create(:default_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      # visit '/admin'

      # expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as a merchant user" do
    xit "will return 404 error on admin routes" do
      user = create(:merchant_employee)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as an admin user" do
    xit "will return 404 error for merchant and cart routes" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/cart'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
