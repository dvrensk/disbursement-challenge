class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :unshipped_cart, class_name: "Cart"
  belongs_to :shipped_cart, class_name: "Cart"

  validates :merchant, :unshipped_cart, :shipped_cart, presence: true
  validates :order_number, presence: true, uniqueness: {scope: :merchant_id}
  validates :confirmed_at, presence: true
end
