class IngredientController < ApplicationController 

  before_action :get_product, only: [:create]

  def create
    params[:ingredients].each do |i|
      puts i
    end
    byebug
  end

  private

  def get_product
    @product = Product.find_by slug: params[:product]
  end

end