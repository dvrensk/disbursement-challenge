class Cart < ApplicationRecord
  validates :principal_amount, presence: true
  attr_readonly :principal_amount
end
