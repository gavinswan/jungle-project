require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create successfully if name, price, quantity and category are valid' do
      @category = Category.new(name: 'test_category')
      @product = Product.new(
        name: 'test_product',
        price_cents: 250,
        quantity: 5,
        category: @category
      )
      expect(@product).to be_valid
    end
    it 'should not create successfully if name is not valid' do
      @category = Category.new(name: 'test_category')
      @product = Product.new(
        name: nil,
        price_cents: 250,
        quantity: 5,
        category: @category
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Name can't be blank"

    end
    it 'should not create successfully if price_cents is not valid' do
      @category = Category.new(name: 'test_category')
      @product = Product.new(
        name: 'test_product',
        price_cents: nil,
        quantity: 5,
        category: @category
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"

    end
    it 'should not create successfully if quantity is not valid' do
      @category = Category.new(name: 'test_category')
      @product = Product.new(
        name: 'test_product',
        price_cents: 250,
        quantity: nil,
        category: @category
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]

    end
    it 'should not create successfully if category is not valid' do
      @category = Category.new(name: 'test_category')
      @product = Product.new(
        name: 'test_product',
        price_cents: 250,
        quantity: 5,
        category: nil
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
    end
  end
end