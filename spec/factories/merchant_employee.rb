FactoryBot.define do
  factory :merchant_employee, class: User do
    name        { Faker::Movies::HarryPotter.character }
    address     { Faker::Address.street_address }
    city        { Faker::Address.city }
    state       { Faker::Address.state }
    zip         { "80207" }
    email       { Faker::Internet.email }
    password    { "password123" }
    role        { 1 }
    association :merchant, factory: :merchant
  end
end
