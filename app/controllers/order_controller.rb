class OrderController < ApplicationController 
  before_action :get_order, only: :destroy

  def index
    @orders = Order.all
    newArray = []
    @orders.map{|o| newArray.push(format_order_info(o))}
    render json: newArray
  end

  def create
    @order = Order.new(order_params)
    puts @order
    params[:batches].each do |b|
      @batch = Batch.find(b[:batch_id])
      @batch.sold = b[:quantity].to_i + @batch.sold
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

  def destroy 
    batches = @order.batch_orders
    batches.each do |b|
      batch = b.batch
      batch.sold = batch.sold - b[:quantity]
      batch.save
    end
    if @order.destroy
      render json: {}
    else
      render json: {message: 'Unable to delete resource'}
    end
  end

  private

  def get_order
    @order = Order.find params[:id]
  end

  def order_params
    params.require(:order).permit(:order_ref)
  end

  def format_order_info(order)
    @batch_orders = order.batch_orders
    @total = @batch_orders.sum{|b| b.quantity}
    return {id: order[:id], order_ref: order[:order_ref], item_count: @batch_orders.size, quantity: @total}
  end

end