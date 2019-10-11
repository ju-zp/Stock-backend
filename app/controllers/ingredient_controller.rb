class IngredientController < ApplicationController 

  def create
    params[:ingredients].each do |i|
      puts i
    end
    byebug
  end

end