FactoryBot.define do
  factory :order, class: Order do
    name        { Faker::Name.name }
    address     { Faker::Address.street_address }
    city        { Faker::Address.city }
    state       { Faker::Address.state }
    zip         { "88888" }
    association :user, factory: :default_user
  end
end