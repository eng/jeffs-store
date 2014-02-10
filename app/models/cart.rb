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

end
