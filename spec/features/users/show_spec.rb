require 'rails_helper'

describe 'User profile show page',type: :feature do
  it "can show a user their profile" do
    user = create(:default_user)

    visit "/"
    click_link "Log In"
    fill_in :email,	with: "#{user.email}"
    fill_in :password,	with: "#{user.password}"
    click_button "Login"

    visit profile_path
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.address)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip)
    expect(page).to have_content(user.email)

    expect(page).to have_button("Edit Profile")
  end
end


# User Story 19, User Profile Show Page
#
# As a registered user
# When I visit my profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data
