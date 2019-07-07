class Product < ApplicationRecord
    has_many :batches
    has_many :batch_orders, through: :batches
    has_many :orders, through: :batch_orders
end
