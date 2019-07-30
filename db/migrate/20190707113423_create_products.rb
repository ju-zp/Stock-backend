class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, unique: true
      t.string :description
      t.string :slug, unique: true
      t.string :image_url
      t.timestamps
    end
  end
end
