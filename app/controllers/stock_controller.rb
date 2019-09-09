class StockController < ApplicationController
  include TransformerHelper

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
    {id: batch[:id], code: batch[:code], quantity: batch[:quantity], product: name, product_id: batch[:product_id], best_before: batch[:best_before], sold: batch.get_sold}
  end

end