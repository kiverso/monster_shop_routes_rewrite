# Monster Shop
## https://monster-shop-2003.herokuapp.com/
### by [Alex Pariseau](https://github.com/arpariseau), [Kyle Iverson](https://github.com/kiverso), and [Daniel Selph](https://github.com/danielpselph)

#### Ruby Version & Gems
- Ruby v2.5.3
- Rails v5.1.7

Production Gems:
|rails|pg|puma|sass-rails|coffee-rails|
|:---:|:---:|:---:|:---:|:---:|
|**uglifier**|**jbuilder**|**factory_bot_rails**|**faker**|**bcrypt**|

Testing Gems:
|byebug|rspec-rails|capybara|launchy|
|:---:|:---:|:---:|:---:|
|**pry**|**simplecov**|**shoulda-matchers**|**orderly**|

#### Database Schema
![Database Schema](https://user-images.githubusercontent.com/54010239/83819926-74966d80-a688-11ea-95fd-a272276e557a.png)

#### Installing Locally
From the command line: 
1. Clone the repo: `git clone https://github.com/arpariseau/monster_shop_2003.git`
1. Install any necessary gems w/ `bundle install`
1. Initialize the database: `rails db:create db:migrate, db:seed}`
1. Run your local rails server: `rails s`
