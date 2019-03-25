require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create(name: 'Whatever')
      @product1 = @category.products.create!(
        name: 'product1',
        price: 500,
        quantity: 10
      )
      @product2 = @category.products.create!(
        name: 'product2',
        price: 700,
        quantity: 20
      )
      # Setup at least one product that will NOT be in the order
      @product3 = @category.products.create!(
        name: 'product3',
        price: 1000,
        quantity: 30
      )
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: 'Jango@Bok.com',
        total_cents: 1200,
        stripe_charge_id: 1
      )
      # 2. build line items on @order
      @line_items1 = @order.line_items.new(
        product: @product1,
        quantity: 5,
        item_price: @product1.price,
        total_price: @product1.price * 5
      )
      @product1.update_column(:quantity, @product1.quantity - 5)

      @line_items2 = @order.line_items.new(
        product: @product2,
        quantity: 10,
        item_price: @product2.price,
        total_price: @product2.price * 6
      )
      @product2.update_column(:quantity, @product2.quantity - 6)
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      @line_items1.save!
      @line_items2.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql(5)
      expect(@product2.quantity).to eql(14)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: 'Jango@Bok.com',
        total_cents: 1200,
        stripe_charge_id: 1
      )
      # 2. build line items on @order
      @line_items1 = @order.line_items.new(
        product: @product1,
        quantity: 5,
        item_price: @product1.price,
        total_price: @product1.price * 5
      )
      @product1.update_column(:quantity, @product1.quantity - 5)

      @line_items2 = @order.line_items.new(
        product: @product2,
        quantity: 10,
        item_price: @product2.price,
        total_price: @product2.price * 6
      )
      @product2.update_column(:quantity, @product2.quantity - 6)
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      @line_items1.save!
      @line_items2.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to eql(30)
    end
  end
end
