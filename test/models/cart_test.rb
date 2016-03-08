require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "must have principal_amount" do
    cart = Cart.new
    assert ! cart.save
    cart.principal_amount = 5.12
    assert cart.save
  end

  test "stores only two decimals" do
    cart = Cart.new(principal_amount: 5.123)
    assert cart.save
    cart.reload
    assert_equal 5.12, cart.principal_amount
  end
end
