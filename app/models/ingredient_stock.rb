class IngredientStock < ApplicationRecord
  belongs_to :ingredient
  has_many :batch_ingredients
  has_many :batchs, through: :batch_ingredients
end
