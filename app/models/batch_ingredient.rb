class BatchIngredient < ApplicationRecord
  belongs_to :batch
  belongs_to :ingredient_stock
end
