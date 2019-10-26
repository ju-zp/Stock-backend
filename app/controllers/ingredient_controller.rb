class IngredientController < ApplicationController

  include TransformerHelper

  def index
    ingredients = Ingredient.all
    render json: TransformerHelper::IngredientFormat.transform_ingredients(ingredients)
  end

end