class AddQuantityToBatchOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :batch_orders, :quantity, :integer
  end
end
