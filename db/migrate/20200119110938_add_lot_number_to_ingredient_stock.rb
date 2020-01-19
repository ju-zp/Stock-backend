class AddLotNumberToIngredientStock < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredient_stocks, :lot, :integer
    add_column :ingredient_stocks, :used, :boolean, default: false
  end
end
