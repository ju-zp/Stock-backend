class CreateBatchIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :batch_ingredients do |t|
      t.references :batch, foreign_key: true
      t.references :ingredient_stock, foreign_key: true

      t.timestamps
    end
  end
end
