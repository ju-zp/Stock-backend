class IngredientStockController < ApplicationController

  before_action :get_ingredient, only: [:index, :create, :update]

  def index
    if @ingredient
      render json: @ingredient.ingredient_stocks.select{|stock| !stock.used }
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

  def update
    stock = @ingredient.ingredient_stocks.select{|stock| stock.lot === params[:lot]}[0]
    if stock 
      stock.lot = params[:lot]
      stock.best_before = params[:best_before]
      stock.rec = params[:rec]
      stock.shelf = params[:shelf]
      stock.used = params[:used]
      if stock.save
        render json: {status: 200}
      else
        render json: {status: 400, message: "Unable to save"}
      end
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