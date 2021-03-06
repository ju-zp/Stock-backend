class Batch < ApplicationRecord
  belongs_to :product
  has_many :batch_orders
  has_many :orders, through: :batch_orders
  has_many :batch_ingredients
  has_many :ingredient_stocks, through: :batch_ingredients

  before_destroy :destroy_batch_orders, :destroy_orders

  def get_sold
    self.batch_orders.sum{|b| b.quantity}
  end

  private 

  def destroy_batch_orders
    self.batch_orders.destroy_all
  end

  def destroy_orders
    self.orders.destroy_all
  end

end
