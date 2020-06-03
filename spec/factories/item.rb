FactoryBot.define do
  factory :item, class: Item do
    name        { Faker::Commerce.product_name}
    description { Faker::Movies::StarWars.quote }
    price       { Faker::Commerce.price}
    image       { "https://images.freeimages.com/images/large-previews/7bc/bald-eagle-1-1400106.jpg" }
    active?     {true}
    inventory   { Faker::Number.between(from: 1, to: 500)}
  end
end
