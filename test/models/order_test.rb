require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "order_number is unique per merchant" do
    o1 = Order.new(merchant: merchants(:one), unshipped_cart: carts(:one), shipped_cart: carts(:two), confirmed_at: 1.hour.ago, order_number: "ASDF1234")
    o2 = Order.new(merchant: merchants(:one), unshipped_cart: carts(:one), shipped_cart: carts(:two), confirmed_at: 1.hour.ago, order_number: "ASDF1234")
    assert o1.save
    assert ! o2.save
  end
end
