class RemoveAmountFromRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_ingredients, :amount
  end
end
