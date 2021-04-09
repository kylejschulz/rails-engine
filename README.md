# README
# Rails-Engine
  *
  https://github.com/kylejschulz/rails-engine
## Authors
- **Kyle Schulz** - github - https://github.com/kylejschulz
## Table of Contents
  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [Method Highlights/Tests](#method-highlights/tests)
  - [Running the tests](#running-the-tests)
  - [API End Points](#api-end-points)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)
## Getting Started
### GemFile/Dependency
  ```
  gem 'pry'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'simplecov'
  gem 'active_designer'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'hirb'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  ```
### Prerequisites
What things you need to install the software and how to install them
* rails
```sh
gem install rails --version 5.2.5
```
### Installing
    1. Clone Repo
    2. Install gem packages: `bundle install`
    3. Setup the database: `rails db:{drop,create,migrate,seed}`
## Method Highlights/Tests
### Search for an items by prices
### Testing this Method
  * Testing items by prices
     - Happy Path
     - Sad Path
     - Edge Case
## Running the tests
In order to run all tests and see coverage run:
  ```
  bundle exec rspec
  ```
## API End Points
  * All Merchants    - http://localhost:3000/api/v1/merchants then add ?per_page=<number_per_page>&page=<page_number>
  * One Merchant     - http://localhost:3000/api/v1/merchants/{{merchant_id}}
  * Find Merchants   - http://localhost:3000/api/v1/merchants/find_all?name=
  * Find_all Merc.   - http://localhost:3000/api/v1/merchants/find_all?name=
  * Merchant's Items - http://localhost:3000/api/v1/merchants/{{merchant_id}}/items
  * Merc most_items  - http://localhost:3000/api/v1/merchants/most_items?quantity=
  * Merc revenue     - http://localhost:3000/api/v1/revenue/merchants?quantity=1
  * Items            - http://localhost:3000/api/v1/items then add ?per_page=<number_per_page>&page=<page_number>
  * One Item         - http://localhost:3000/api/v1/items/{{item_id}}
  * Create Item      - Post 'http://localhost:3000/api/v1/items'
  * Update Item      - Patch 'http://localhost:3000/api/v1/items'
  * Delete Item      - Delete 'http://localhost:3000/api/v1/items/{{item_id}}'
  * Item's Merchant  - http://localhost:3000/api/v1/items/{{item_id}}/merchant
  * Find Items name  - http://localhost:3000/api/v1/items/find?name=
  * Find Items Price - http://localhost:3000/api/v1/items/find?min_price= or max_price, or both
  * Revenue          - http://localhost:3000/api/v1/revenue?start={{start_date}}&end={{end_date}}
  * Single Merc Rev  - http://localhost:3000/api/v1/revenue/merchants/{{merchant_id}}
## Built With
  - Ruby/Rails
## License
  - MIT License
## Acknowledgments
  - The Turing School of Software & Design instructors and students of the 2011 cohort.
