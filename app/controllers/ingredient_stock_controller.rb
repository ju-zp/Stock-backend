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
  end

  private

  def get_ingredient
    @ingredient = Ingredient.find_by name: params[:name]
  end

end