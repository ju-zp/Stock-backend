class Batch < ApplicationRecord
  belongs_to :product, dependent: :destroy
  has_many :batch_orders
  has_many :orders, through: :batch_orders
end
