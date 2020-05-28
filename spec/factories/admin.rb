FactoryBot.define do
  factory :admin, class: User do
    name      { Faker::Movies::StarWars.character }
    address   { Faker::Address.street_address }
    city      { Faker::Address.city }
    state     { Faker::Address.state }
    zip       { "85048" }
    email     { Faker::Internet.email }
    password  { "password123" }
    role      { 2 }
  end
end