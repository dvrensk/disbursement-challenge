require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "has unique name" do
    m1 = Merchant.new(name: "unique")
    m2 = Merchant.new(name: "unique")
    assert m1.save
    assert ! m2.save
  end
end
