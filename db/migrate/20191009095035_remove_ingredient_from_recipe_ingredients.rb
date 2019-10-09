class RemoveIngredientFromRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_reference :recipe_ingredients, :ingredient, foreign_key: true
    add_reference :recipe_ingredients, :ingredient_stock, foreign_key: true
  end
end
