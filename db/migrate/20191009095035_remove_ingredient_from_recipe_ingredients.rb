class RemoveIngredientFromRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_reference :recipe_ingredients, :ingredient_id, foreign_key: true
    add_column :recipe_ingredients, :ingredient_stock_id, foreign_key: true
  end
end
