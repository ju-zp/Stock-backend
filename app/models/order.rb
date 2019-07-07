class Order < ApplicationRecord
    has_many :batch_orders
end
