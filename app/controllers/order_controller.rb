class OrderController < ApplicationController 

  def index
    @orders = Order.all
    newArray = []
    @orders.map{|o| newArray.push(formatOrderInfo(o))}
    render json: newArray
  end

  private

  def formatOrderInfo(order)
    @batch_orders = order.batch_orders
    @total = @batch_orders.sum{|b| b.quantity}
    return {order_ref: order[:order_ref], item_count: @batch_orders.size, quantity: @total}
  end

end