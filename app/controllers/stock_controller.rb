class StockController < ApplicationController
  include TransformerHelper

  before_action :get_product, only: [:in_stock]

  def product_list
    @products = Product.all
    @newArray = []
    @products.map{|p| @newArray.push(TransformerHelper::ProductList.transform_product_info(p))}
    render json: @newArray.reject{|i| !i}
  end

  def in_stock
    @orderProducts = @product.batches.order({ best_before: :asc }).select{|b| b.get_sold != b.quantity}
    @newArr = []
    @orderProducts.map{|b| @newArr.push(transform_batch(b, @product.name))} 
    render json: @newArr
  end

  def transform_batch(batch, name)
    { code: batch[:code], stock: batch[:quantity] - batch.get_sold, best_before: batch[:best_before] }
  end

  private 

  def get_product
    @product = Product.find_by slug: params[:slug]
  end

end