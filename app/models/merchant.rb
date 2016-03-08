class Merchant < ApplicationRecord
  validates :name, uniqueness: true
end
