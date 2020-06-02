require 'rails_helper'

RSpec.describe "merchant dashboard" do
  context "as a merchant employee" do
    before(:each) do
      @merchant = create(:merchant)
      @employee = create(:merchant_employee, merchant_id: @merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)
    end

    it "can see name and address of employee that I work for" do

      visit merchant_path

      within ".contact" do
        expect(page).to have_content(@merchant.name) 
        expect(page).to have_content(@merchant.address) 
        expect(page).to have_content(@merchant.city) 
        expect(page).to have_content(@merchant.state) 
        expect(page).to have_content(@merchant.zip) 
      end
    end
  end
end
# As a merchant employee
# When I visit my merchant dashboard ("/merchant")
# I see the name and full address of the merchant I work for