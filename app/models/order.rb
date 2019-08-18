class Order < ApplicationRecord
    has_many :batch_orders, dependent: :destroy
end
