class CreateIngredientStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_stocks do |t|
      t.references :ingredient, foreign_key: true
      t.date :rec
      t.date :best_before
      t.date :shelf

      t.timestamps
    end
  end
end
