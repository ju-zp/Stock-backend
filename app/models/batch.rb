class Batch < ApplicationRecord
  belongs_to :product
  has_many :batch_orders
  has_many :orders, through: :batch_orders

  before_destroy :destroy_batch_orders, :destroy_orders

  def get_sold_amount
    orders = self.batch_orders
    total = 0
    orders.each{|o| total += o.quantity}
    total
  end

  private 

  def destroy_batch_orders
    self.batch_orders.destroy_all
  end

  def destroy_orders
    self.orders.destroy_all
  end

end
