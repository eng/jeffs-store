class CartItemsController < ApplicationController
  before_filter :get_cart

  def index
    @cart_items = @cart.cart_items
  end

  def create
    product = Product.find(params[:product_id])
    @cart.add_product(product)
    redirect_to cart_items_path, notice: 'Product added to cart.'
  end

  def destroy
    product = @cart.cart_items.find(params[:id]).product
    @cart.remove_product(product)
    redirect_to cart_items_path, notice: 'Product removed from cart.'
  end

  def clear
    @cart.empty
    redirect_to cart_items_path, notice: 'Cart emptied.'
  end

  private

    def get_cart
      @cart = Cart.find_or_create_by(session_id: session.id)
    end

end