class StockController < ApplicationController

  def product_list
    @products = Product.all
    @newArray = []
    @products.map{|p| @newArray.push(transform_product(p))}
    render json: @newArray
  end


  def transform_product(product)
    @batches = product.batches
    @newArr = []
    @batches.map{|b| @newArr.push(transform_batch(b, product.name))}
    {product: product, batches: @newArr}
  end

  def transform_batch(batch, name)
    { code: batch[:code], quantity: batch[:quantity], product_id: batch[:product_id], sold: batch.get_sold}
  end


end