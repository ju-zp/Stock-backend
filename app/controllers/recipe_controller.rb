class RecipeController < ApplicationController

  before_action :get_product, only: [:create, :update]

  def create
    if(!@product.recipe)
      recipe = Recipe.new()
      recipe.product = @product
      recipe.save
      if add_ingredients_to_recipe(params, recipe)
        render json: {status: 200}
      else
        render json: {status: 200, message: "Unable to save recipe"}
      end
    else
      render json: {status: 200, message: "Product already has a recipe"}
    end
  end

  def update
    recipe = @product.recipe
    if add_ingredients_to_recipe(params, recipe)
      render json: {status: 200}
    else
      render json: {status: 200, message: "Unable to save recipe"}
    end
  end

  private

  def get_product
    @product = Product.find_by name: params[:product]
  end

  def add_ingredients_to_recipe(params, recipe)
    newArray = []
    params[:ingredients].each do |i|
      newArray.push(Ingredient.find_or_create_by(name: i)) 
      recipe.ingredients = newArray
    end
    recipe.save
  end

end