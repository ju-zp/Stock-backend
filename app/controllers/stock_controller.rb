class StockController < ApplicationController
  include TransformerHelper

  def product_list
    @products = Product.all
    @newArray = []
    @products.map{|p| @newArray.push(TransformerHelper::ProductList.transform_product_info(p))}
    render json: @newArray.reject{|i| !i}
  end

end