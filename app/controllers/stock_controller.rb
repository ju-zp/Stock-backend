class StockController < ApplicationController
  include TransformerHelper

  before_action :get_product, only: [:in_stock]

  def product_list
    products = Product.all
    newArray = []
    products.map{|p| newArray.push(TransformerHelper::ProductList.transform_product_info p )}
    render json: newArray.reject{|i| !i}
  end

  def in_stock
    orderProducts = @product.batches.order({ best_before: :asc })
    newArr = []
    orderProducts.map{|b| newArr.push(transform_batch b )}
    if newArr[0]
      render json: newArr
    else
      render json: { message: 'There is no stock available for this product'}
    end
  end

  def transform_batch batch 
    if batch[:quantity] - batch.get_sold > 0
      { code: batch[:code], stock: batch[:quantity] - batch.get_sold, best_before: batch[:best_before] }
    end
  end

  private 

  def get_product
    @product = Product.find_by slug: params[:slug]
  end

end