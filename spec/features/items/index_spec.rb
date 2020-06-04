require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to_not have_link(@dog_bone.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).to_not have_link(@dog_bone.name)
      expect(page).to_not have_content(@dog_bone.description)
      expect(page).to_not have_content("Price: $#{@dog_bone.price}")
      expect(page).to_not have_content("Inactive")
      expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
      expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    it "links to the show page from the item's image" do

      visit items_path
      click_link "img-link-#{@tire.id}"
      expect(current_path).to eq("/items/#{@tire.id}")

      visit items_path
      click_link "img-link-#{@pull_toy.id}"
      expect(current_path).to eq("/items/#{@pull_toy.id}")
    end

    it "has statistics depending on the number of items ordered" do
      user = create(:default_user)
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      homer = Order.create(name: "Homer Simpson", address: "742 Evergreen Terrace", city: "Springfield", state: "CO", zip: 80000, user_id: user.id)
      @dog_bone.update_attribute(:active?, true)
      ItemOrder.create(order_id: homer.id, item_id: @tire.id, price: @tire.price, quantity: 2)
      ItemOrder.create(order_id: homer.id, item_id: @pull_toy.id, price: @pull_toy.price, quantity: 1)
      ItemOrder.create(order_id: homer.id, item_id: @dog_bone.id, price: @dog_bone.price, quantity: 5)
      ItemOrder.create(order_id: homer.id, item_id: paper.id, price: paper.price, quantity: 3)
      ItemOrder.create(order_id: homer.id, item_id: pencil.id, price: pencil.price, quantity: 4)

      visit items_path
      within ".most-popular-items" do
        expect(page).to have_content("5")
        expect(@dog_bone.name).to appear_before(pencil.name)
        expect(page).to have_content("4")
        expect(pencil.name).to appear_before(paper.name)
        expect(page).to have_content("3")
        expect(paper.name).to appear_before(@tire.name)
        expect(page).to have_content("2")
        expect(@tire.name).to appear_before(@pull_toy.name)
        expect(page).to have_content("1")
      end

      within ".least-popular-items" do
        expect(page).to have_content("1")
        expect(@pull_toy.name).to appear_before(@tire.name)
        expect(page).to have_content("2")
        expect(@tire.name).to appear_before(paper.name)
        expect(page).to have_content("3")
        expect(paper.name).to appear_before(pencil.name)
        expect(page).to have_content("4")
        expect(pencil.name).to appear_before(@dog_bone.name)
        expect(page).to have_content("5")
      end
    end
  end
end
