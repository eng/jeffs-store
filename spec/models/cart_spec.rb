require 'spec_helper'

describe Cart do
  before :each do
    @mms = Product.create(name: 'M&Ms', price: 1.0)
    @jersey = Product.create(name: 'Blackhawks Jersey', price: 40.0)
    @products = Product.all
    @cart = Cart.first
  end

  def fill_cart
    @cart.add_product(@mms)
    @cart.add_product(@jersey)
  end

  describe :add_product do
    it 'adds an item to cart' do
      @cart.add_product(@jersey)
      assert_equal 1, @cart.items_count
    end

    it 'updates quantity when the item is a duplicate' do
      @cart.add_product(@jersey)
      @cart.add_product(@jersey)
      first_item_in_cart = @cart.cart_items.first
      assert_equal 2, first_item_in_cart.qty
    end
  end

  describe :subtotal do
    it 'calculates the subtotal' do
      fill_cart
      assert_equal 41.0, @cart.subtotal
    end

    it 'has a subtotal of 0 when empty' do
      assert_equal 0.0, @cart.subtotal
    end
  end

  describe :tax do
    it "calculates the tax" do
      fill_cart
      assert_equal 2.46, @cart.tax
    end
  end

  describe :shipping do
    it "calculates shipping" do
      fill_cart
      assert_equal 5.0, @cart.shipping
    end

    it "is 0 when the cart is empty" do
      assert_equal 0.0, @cart.shipping
    end
  end

  describe :total do
    it 'calculates the grand total' do
      fill_cart
      assert_equal 48.46, @cart.total
    end
  end

  describe :remove_product do 
    it 'removes an item from the cart' do
      fill_cart
      @cart.remove_product(@jersey)
      assert_equal 1, @cart.items_count
    end
  end

  describe :empty do
    it 'empties the whole cart' do
      fill_cart
      @cart.empty
      assert_equal 0, @cart.items_count
    end
  end

end
