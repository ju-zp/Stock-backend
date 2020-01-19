class AddLotNumberToIngredientStock < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredient_stocks, :lot, :integer
  end
end
