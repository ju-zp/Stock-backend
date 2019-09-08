class OrderController < ApplicationController 
  before_action :get_order, only: [:show, :update, :destroy]

  def index
    @orders = Order.all
    newArray = []
    @orders.map{|o| newArray.push(format_order_info(o))}
    render json: newArray
  end

  def create
    @order = Order.new(order_params)
    params[:batches].each do |b|
      @batch = Batch.find_by code: b[:batch]
      @batch_order = BatchOrder.new
      @batch_order.batch = @batch
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

  def show
    @batch_orders = @order.batch_orders
    data = {}
    data['order_ref'] = @order[:order_ref]
    data['id'] = @order[:id]
    newArray = []
    @batch_orders.each do |b|
      newObj = {}
      newObj['quantity'] = b.quantity
      newObj['batch'] = b.batch
      newObj['product'] = b.batch.product.name
      newArray.push(newObj)
    end
    data['products'] = newArray
    render json: {body: data}
  end

  def update
    @order.batch_orders.destroy_all
    @order[:order_ref] = params[:order_ref]
    params[:batches].each do |b|
      @batch = Batch.find_by code: b[:batch]
      @batch_order = BatchOrder.new
      @batch_order.batch = @batch
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