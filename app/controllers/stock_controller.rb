class StockController < ApplicationController

  def product_list
    @products = Product.all
    @newArray = []
    @products.map{|p| @newArray.push(transform_product_info(p))}
    render json: @newArray
  end

  private

  def transform_product_info(product)
    @batches = product.batches
    @newArr = []
    @batches.map do |b|
      if(0 < b.quantity - b.get_sold)
        @newArr.push(transform_batch(b, product.name))
      end
    end
    if(!@newArr.empty?)
      {product: product[:name], batches: @newArr}
    end
  end

  def transform_batch(batch, name)
    { code: batch[:code], quantity: batch[:quantity], product_id: batch[:product_id], sold: batch.get_sold}
  end


end