# require 'cloudinary'

class ProductController < ApplicationController
  before_action :get_product, only: [:show, :update, :destroy, :in_stock, :orders, :ingredients, :ingredient_stock]

  include TransformerHelper


  def index
    products = Product.all
    newArray = []
    products.map{|p| newArray.push(TransformerHelper::ProductFormat.transform_product p )}
    render json: newArray
  end

  def new
    product = Product.new
  end

  def create
    product = Product.new(product_params)
    sample = Cloudinary::Uploader.upload(params[:image_url][:file], :public_id => params[:image_url][:name], :overwrite => true)
    product[:image_url] = sample['url']
    if product.validate 
      if product.save
        render json: {status: 200}
      else
        render json: {status: 400, message: "Unable to save"}
      end

    else
      render json: { error: product.errors.messages}, status: :not_acceptable
    end
  end

  def show
    ingredients = TransformerHelper::IngredientFormat.transform_ingredients(@product.ingredients)
    orderProducts = @product.batches.order({ best_before: :asc })
    newArr = []
    orderProducts.map{|b| newArr.push(TransformerHelper::BatchFormat.transform_batch(b, @product.name))} 
    render json: {product: @product, ingredients: ingredients, batches: newArr, stock: {total: @product.get_total, sold: @product.get_sold, stock: @product.get_stock}}
  end

  def update
    @product.update(product_params)
    if @product.save
      render json: {status: 200}
    else
      render json: {status: 400, message: "Unable to update"}
    end
  end

  def destroy
    @product.destroy
    render json: {status: 200}
  end

  def orders
    newArray = []
    @product.orders.order({ created_at: :desc }).map{|o| newArray.push(TransformerHelper::OrderFormat.transform_order o )}
    render json: newArray
  end

  def ingredients
    render json: TransformerHelper::IngredientFormat.transform_product_ingredients(@product.ingredients)
  end

  def ingredient_stock
    ingredients = @product.ingredients
    if ingredients.length > 0
      data = ingredients.map{|ingredient| { name: ingredient.name, stock: ingredient.ingredient_stocks.select{|stock| !stock.used}.map{|stock| {lot: stock.lot, best_before: stock.best_before}}}}
      render json: data
    else
      render json: {status: 400, message: "Unable to find ingredients"}
    end
  end

  private 

  def product_params
    params.require(:product).permit(:name, :description, :image_url)
  end

  def get_product
    @product = Product.find_by slug: params[:slug]
  end
    
end
