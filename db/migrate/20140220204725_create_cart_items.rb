class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true
      t.references :product, index: true
      t.integer :qty

      t.timestamps
    end
  end
end
