class IngredientStockController < ApplicationController

  before_action :get_ingredient, only: [:index, :create]

  def index
    if @ingredient
      render json: @ingredient.ingredient_stocks
    else
      render json: { message: 'Could not find ingredient'}
    end
  end

  def create
    stock = IngredientStock.new ingredient_stock_params
    stock.ingredient = @ingredient
    if stock.save
      render json: {status: 200}
    else
      render json: {status: 400, message: "Unable to save"}
    end
  end

  private

  def ingredient_stock_params
    params.require(:ingredient_stock).permit(:lot, :rec, :best_before, :shelf)
  end

  def get_ingredient
    @ingredient = Ingredient.find_by name: params[:name].capitalize
  end

end