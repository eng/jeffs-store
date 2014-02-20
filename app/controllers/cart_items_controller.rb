class CartItemsController < ApplicationController
  before_filter :get_cart

  def index
    @cart_items = @cart.cart_items
  end

  def create
    @product = Product.find(params[:product_id])
    existing_item = @cart.cart_items.where(product: @product).first
    if existing_item
      existing_item.update_attributes(qty: existing_item.qty + 1)
    else
      @cart.cart_items.create(product: @product, qty: 1)
    end
    redirect_to cart_items_path, notice: 'Product added to cart.'
  end

  private

    def get_cart
      @cart = Cart.find_or_create_by(session_id: session.id)
    end

end