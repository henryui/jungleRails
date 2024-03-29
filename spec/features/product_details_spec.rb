require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see a product's detail" do
    # ACT
    visit root_path

    find('a', text: 'Details »', match: :first).click
    # sleep to wait for loading
    sleep 5
    # DEBUG / VERIFY
    save_screenshot
    # puts page.html
  end

end