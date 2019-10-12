class RecipeController < ApplicationController

  before_action :get_product, only: [:create]

  def create
    recipe = Recipe.new()
    recipe.product = @product
    if (recipe.save())
      newArray = []
      params[:ingredients].each do |i|
        newArray.push(Ingredient.create(name: i)) 
        recipe.ingredients = newArray
      end
      render json: {status: 200}
    else
      render json: {status: 200, message: "Unable to save recipe"}
    end
  end

  private

  def get_product
    @product = Product.find_by slug: params[:product]
  end

end