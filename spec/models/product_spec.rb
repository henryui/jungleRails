require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject do
      @category = Category.create(name: 'Whatever')
      @category.products.new(
        name: 'Any',
        price: 200,
        quantity: 20
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
      expect(subject.errors.full_messages.size).to eql(0)
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a price' do
      subject.price = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a category' do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end
  end
end
