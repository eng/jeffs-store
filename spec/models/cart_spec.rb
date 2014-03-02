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
      @cart.items_count.should eq(1)
    end

    it 'updates quantity when the item is a duplicate' do
      @cart.add_product(@jersey)
      @cart.add_product(@jersey)
      first_item_in_cart = @cart.cart_items.first
      first_item_in_cart.qty.should eq(2)
    end
  end

  describe :subtotal do
    it 'calculates the subtotal' do
      fill_cart
      @cart.subtotal.should eq(41.0)
    end

    it 'has a subtotal of 0 when empty' do
      @cart.subtotal.should eq(0.0)
    end
  end

  describe :tax do
    it "calculates the tax" do
      fill_cart
      @cart.tax.should eq(2.46)
    end
  end

  describe :shipping do
    it "calculates shipping" do
      fill_cart
      @cart.shipping.should eq(5.0)
    end

    it "is 0 when the cart is empty" do
      @cart.shipping.should eq(0)
    end
  end

  describe :total do
    it 'calculates the grand total' do
      fill_cart
      @cart.total.should eq(48.46)
    end
  end

  describe :remove_product do 
    it 'removes an item from the cart' do
      fill_cart
      @cart.remove_product(@jersey)
      @cart.items_count.should eq(1)
    end
  end

  describe :empty do
    it 'empties the whole cart' do
      fill_cart
      @cart.empty
      @cart.items_count.should eq(0)
    end
  end

end
