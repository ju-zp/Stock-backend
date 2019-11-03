class IngredientController < ApplicationController

  include TransformerHelper

  def index
    ingredients = Ingredient.all
    render json: TransformerHelper::IngredientFormat.transform_ingredients(ingredients)
  end

  def create
    ingredient = Ingredient.new ingredient_params
    if ingredient.save
      render json: {status: 200}
    else
      render json: {status: 400, message: "Unable to save"}
    end
  end

  private
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

end