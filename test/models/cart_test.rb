require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @mms = Product.create(name: 'M&Ms')
    @jersey = Product.create(name: 'Blackhawks Jersey')
    @products = Product.all
    @cart = Cart.first
  end

  test 'should be able to add an item to cart' do
    @cart.add_product(@jersey)
    assert_equal 1, @cart.items_count
  end

  test 'if duplicate product added to cart, update quantity' do
    @cart.add_product(@jersey)
    @cart.add_product(@jersey)
    first_item_in_cart = @cart.cart_items.first
    assert_equal 2, first_item_in_cart.qty
  end

  test 'should calculate subtotal' do
    @cart.add_product(@mms)
    @cart.add_product(@jersey)
    assert_equal 41.0, @cart.subtotal
  end

end
