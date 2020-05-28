FactoryBot.define do
  factory :default_user, class: User do
    name      { Faker::TvShows::RickAndMorty.character }
    address   { Faker::Address.street_address }
    city      { Faker::Address.city }
    state     { Faker::Address.state }
    zip       { "23456" }
    email     { Faker::Internet.email }
    password  { "password123" }
    role      { 0 }
  end
end
