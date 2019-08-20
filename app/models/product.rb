class Product < ApplicationRecord
    has_many :batches
    has_many :batch_orders, through: :batches
    has_many :orders, through: :batch_orders
    before_create :set_slug
    validates_uniqueness_of :name, :slug

    def to_param
        slug
    end

    def get_total
        batches.sum{|b| b.quantity}
    end

    def get_sold
        batches.sum{|b| b.get_sold}
    end

    def get_stock
        get_total - get_sold
    end

    private 

    def set_slug
        self.slug = self.name.gsub(' ', '-')
    end
end
