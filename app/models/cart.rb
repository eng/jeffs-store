class Cart < ActiveRecord::Base
  has_many :cart_items

  def add_product(product)
    existing_item = self.cart_items.where(product: product).first
    if existing_item
      existing_item.update_attributes(qty: existing_item.qty + 1)
    else
      self.cart_items.create(product: product, qty: 1)  
    end
  end

  def items_count
    self.cart_items.count
  end

  def subtotal
    self.cart_items.collect { |cart_item| cart_item.product.price * cart_item.qty }.inject(:+) || 0
  end

  def tax
    subtotal * 0.06
  end

  def shipping
    subtotal > 0 ? 5.0 : 0.0
  end

  def total
    subtotal + tax + shipping
  end

  def remove_product(product)
    self.cart_items.where(product: product).first.destroy
  end

  def empty
    self.cart_items.clear
  end

end
