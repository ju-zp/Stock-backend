class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches do |t|
      t.string :code
      t.integer :quantity
      t.references :product, foreign_key: true
      t.datetime :best_before

      t.timestamps
    end
  end
end
