class CartItemsController < ApplicationController
  before_filter :get_cart

  def index
    @cart_items = @cart.cart_items
    @subtotal = 0.0
    @cart_items.each do |cart_item|
      @subtotal += cart_item.product.price * cart_item.qty
    end
    @tax = @subtotal * 0.06
    @shipping = @subtotal > 0 ? 5 : 0
    @total = @subtotal + @tax + @shipping
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

  def destroy
    @cart.cart_items.find(params[:id]).destroy
    redirect_to cart_items_path, notice: 'Product removed from cart.'
  end

  def clear
    @cart.cart_items.delete_all
    redirect_to cart_items_path, notice: 'Cart emptied.'
  end

  private

    def get_cart
      @cart = Cart.find_or_create_by(session_id: session.id)
    end

end
