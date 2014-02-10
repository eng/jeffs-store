require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    mms = Product.create(name: 'M&Ms')
    jersey = Product.create(name: 'Blackhawks Jersey')
    @products = Product.all
    @cart = Cart.first
  end
end
