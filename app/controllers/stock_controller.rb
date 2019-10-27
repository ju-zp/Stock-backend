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

    orderProducts.map{|b| newArr.push(TransformerHelper::Stock.transform_batch b )}

    if newArr.any?
      render json: newArr
    else
      render json: { message: 'There is no stock available for this product'}
    end
  end

  def ingredient_stock
    puts params 
  end

  private 

  def get_product
    @product = Product.find_by slug: params[:slug]
  end

end