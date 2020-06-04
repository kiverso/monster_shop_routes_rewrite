# Monster Shop
## https://monster-shop-2003.herokuapp.com/
### by [Alex Pariseau](https://github.com/arpariseau), [Kyle Iverson](https://github.com/kiverso), and [Daniel Selph](https://github.com/danielpselph)

#### Ruby Version & Gems
- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/200px-Ruby_logo.svg.png" alt="Ruby Logo" width="20" height="20"/> v2.5.3
- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Ruby_On_Rails_Logo.svg/200px-Ruby_On_Rails_Logo.svg.png" alt="Rails Logo" width="60" height="20" /> v5.1.7

Production Gems:
|rails|pg|puma|sass-rails|coffee-rails|
|:---:|:---:|:---:|:---:|:---:|
|**uglifier**|**jbuilder**|**bcrypt**|**web-console**|**listen**|

Testing Gems:
|byebug|rspec-rails|capybara|launchy|pry|
|:---:|:---:|:---:|:---:|:---:|
|**simplecov**|**shoulda-matchers**|**orderly**|**factory_bot_rails**|**faker**|

#### Database Schema
  The database consists of Users, Merchants, Items, Reviews, Orders, and Item Orders.  
  Merchants have many Items, as well as many users through an optional field in the user, merchant_id. The users that belong to merchants are users with an employee role who work for a the merchant.  
  Users can have many orders, and an order will belong to a single user. These orders can have many items through the Item Orders table. Each order can have many Item Orders which link an item to the order. Likewise, each item can have many orders through this Item Orders table.  Items can also have many reviews and a review will only belong to one item.
![Database Schema](https://user-images.githubusercontent.com/54010239/83819926-74966d80-a688-11ea-95fd-a272276e557a.png)

#### Installing Locally
From the command line: 
1. Clone the repo: `git clone https://github.com/arpariseau/monster_shop_2003.git`
1. Install any necessary gems w/ `bundle install`
1. Initialize the database: `rails db:create db:migrate, db:seed}`
1. Run your local rails server: `rails s`
