# Jungle

A mini e-commerce application built with Rails 4.2.


## Final Product

!["The order page"](https://github.com/henryui/jungleRails/blob/master/docs/Jungle1.png?raw=true)
*The order page*



!["The cart page"](https://github.com/henryui/jungleRails/blob/master/docs/Jungle2.png?raw=true)
*The cart page*



!["Product/review show page"](https://github.com/henryui/jungleRails/blob/master/docs/Jungle3.png?raw=true)
*Product/review show page


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

## Features

* Index page displays all products with their name, image, description, and price
 * Sold out badge is displayed if a product's quantity is zero
 * 'Add' button is there to add the item to the cart as a user or visitor
 * 'Details' button is there to go to the product specific show page

* Product show page displays product's name, image, description, quantity, price, rating, and reviews
  * Users can post a review with the form, providing description and rating (from 1 to 5)
  * Reviews are ordered by most recent, and the ratings appear as stars
  * Overall rating is shown as stars, with average rating in decimal and number of reviews displayed
  * Users can delete their own reviews

* Admin user with his/her email defined in .env can access Admin panel in the navbar ('ADMIN_EMAIL')
  * Products and Categories page for the Admin account is setup to add or delete products/categories

* Login, Signup button for the visitor, Logout button for the user is displayed in the navbar
  * Users can log out from anywhere, and cannot sign up with a duplicate email
  * Visitors can sign up with their name, email, and password from the register page
  * Passwords are stored securely with bcrypt
  * Visitors can log in with their email and password from the log in page

* Cart button is on the navbar, clicking it will direct to the cart page
  * Displays message and link to home if cart is empty
  * Displays products information that were added to the cart, along with their sub-total price
  * The quantity of the products added can be adjusted using '+' and '-' buttons
  * Visitors can purchase the items in the cart; the order page will be created using the provided test email in .env file ('TEST_EMAIL')
  * Users can purchase the items in the cart; the order page will be created using their email
  * A receipt with the order's id and link to the order page is emailed to the user's email

* The order page shows details of the products purchased, with the sub-total and the email used to purchase the items
