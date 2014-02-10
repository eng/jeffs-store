require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    mms = Product.create(name: 'M&Ms')
    jersey = Product.create(name: 'Blackhawks Jersey')
    @products = Product.all
    @cart = Cart.first
  end

  test 'should be able to add an item to cart' do
    @cart.add_product(jersey)
    assert_equal 1, @cart.items_count
  end
end
