require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @mms = Product.create(name: 'M&Ms', price: 1.0)
    @jersey = Product.create(name: 'Blackhawks Jersey', price: 40.0)
    @products = Product.all
    @cart = Cart.first
  end

  def fill_cart
    @cart.add_product(@mms)
    @cart.add_product(@jersey)
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
    fill_cart
    assert_equal 41.0, @cart.subtotal
  end

  test 'should calculate tax' do
    fill_cart
    assert_equal 2.46, @cart.tax
  end

  test 'should calculate shipping' do
    fill_cart
    assert_equal 5.0, @cart.shipping
  end

  test 'should calculate grand total' do
    fill_cart
    assert_equal 48.46, @cart.total
  end

end
