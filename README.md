# Jungle

A mini e-commerce application built with Rails 4.2.


## Final Product


## Setup

1. Fork & Clone
2. Run `bundle install` to install dependencies
  * May need `rvm` and `rvm use 2.3.0`
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Create a database named 'jungle_development' in psql `create databse jungle_development;`
10. Run `bin/rails s` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

##
