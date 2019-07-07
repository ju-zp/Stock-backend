class CreateBatchOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :batch_orders do |t|
      t.references :batch, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
