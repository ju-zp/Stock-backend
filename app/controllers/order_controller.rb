class OrderController < ApplicationController 

  def index
    @orders = Order.all
    newArray = []
    @orders.map{|o| newArray.push(formatOrderInfo(o))}
    render json: newArray
  end

  def create
    @order = Order.new(order_params)
    puts @order
    params[:batches].each do |b|
      @batch = Batch.find(b[:batch_id])
      @batch.sold = b[:quantity] + @batch.sold
      @batch.save
      @batch_order = BatchOrder.new
      @batch_order.batch_id = b[:batch_id]
      @batch_order.quantity = b[:quantity].to_i
      @batch_order.order = @order
      @batch_order.save
    end
    if @order.save
      render json: {status: 200}
    else
      render json: {status: 400, message: "Unable to save"}
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_ref)
  end

  def formatOrderInfo(order)
    @batch_orders = order.batch_orders
    @total = @batch_orders.sum{|b| b.quantity}
    return {order_ref: order[:order_ref], item_count: @batch_orders.size, quantity: @total}
  end

end