class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.decimal :principal_amount, precision: 16, scale: 2, null: false

      t.timestamps
    end
  end
end
