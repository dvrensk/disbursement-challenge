class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :merchant, foreign_key: true, index: true, null: false
      t.string :order_number, null: false
      t.datetime :confirmed_at, null: false
      t.datetime :shipped_at
      t.references :unshipped_cart, foreign_key: true, index: true, null: false
      t.references :shipped_cart, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
