class AddUsedToIngredientStock < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredient_stocks, :used, :boolean
  end
end
