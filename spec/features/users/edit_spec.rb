require 'rails_helper'

describe 'User profile show page',type: :feature do
  before :each do
    @user = create(:default_user)
    @user_new = create(:default_user)
  end

  it "can show a user their profile" do
    visit "/"
    click_link "Log In"
    fill_in :email,	with: "#{@user.email}"
    fill_in :password,	with: "#{@user.password}"
    click_button "Login"

    click_button "Edit Profile"
    expect(current_path).to eq "/users/edit"
    expect(find_field(:name).value).to eq(@user.name)
    expect(find_field(:address).value).to eq(@user.address)
    expect(find_field(:state).value).to eq(@user.state)
    expect(find_field(:city).value).to eq(@user.city)
    expect(find_field(:zip).value).to eq(@user.zip)
    expect(find_field(:email).value).to eq(@user.email)

    fill_in :name,	with: @user_new.name
    fill_in :address,	with: @user_new.address
    fill_in :city,	with: @user_new.city
    fill_in :state,	with: @user_new.state
    fill_in :zip,	with: @user_new.zip
    fill_in :email,	with: @user_new.email
    click_button "Submit"

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("User profile updated!")
    expect(page).to have_content(@user_new.name)
    expect(page).to have_content(@user_new.address)
    expect(page).to have_content(@user_new.state)
    expect(page).to have_content(@user_new.city)
    expect(page).to have_content(@user_new.zip)
    expect(page).to have_content(@user_new.email)
  end
end

# User Story 20, User Can Edit their Profile Data
#
# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information
