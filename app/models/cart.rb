class Cart < ApplicationRecord
  validates :principal_amount, presence: true
end
