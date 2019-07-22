class Product < ApplicationRecord
    has_many :batches
    has_many :batch_orders, through: :batches
    has_many :orders, through: :batch_orders
    before_create :set_slug

    def to_param
        slug
    end

    private 

    def set_slug
        self.slug = self.name.gsub(' ', '-')
    end
end
