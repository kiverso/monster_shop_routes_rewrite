require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_confirmation_of(:password)}
  end

  describe 'roles' do
    it 'can have default role of default' do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1")
                
      expect(user1.role).to eq("default")
    end

    it 'can have role of merchant' do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 1)

      expect(user1.role).to eq("merchant")
    end

    it 'can have role of admin' do
      user1 = User.create(name: "Rick Sanchez",
                          address: "123 Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202",
                          email: "PickleRick@example.com",
                          password: "GetSchwifty1",
                          role: 2)

      expect(user1.role).to eq("admin")
    end
  end
end