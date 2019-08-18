class BatchController < ApplicationController 
<<<<<<< HEAD
  before_action :get_batch, only: [:destroy]
=======
  before_action :get_batch, only: [:show, :update]
  before_action :get_product, only: [:create, :update]
>>>>>>> dacc2c4d214d8bb965aedf90e9f40f3919ee9e54

  def index
    @batches = Batch.all
    newArray = []
    @batches.map{|b|newArray.push(transform_batch_obj(b))}
    render json: newArray
  end

  def create
    @batch = Batch.new(batch_params)
<<<<<<< HEAD
    @product = get_product(params[:barSlug])
=======
>>>>>>> dacc2c4d214d8bb965aedf90e9f40f3919ee9e54
    @batch.sold = 0
    @batch.product = @product
    @batch.best_before = Date.parse(params[:bestBefore])
    if(@batch.save)
      render json: {}
    else
      render json: {message: 'Unable to save'}, status: 400
    end
  end

<<<<<<< HEAD
  def destroy
    if @batch.destroy
      render json: {}
    else
      render json: {message: 'Unable to delete resource'}
=======
  def show
    render json: { body: transformBatchObj(@batch) }
  end

  def update
    @batch.code = params[:code]
    @batch.quantity = params[:quantity]
    @batch.best_before = Date.parse(params[:bestBefore])
    @batch.product = @product
    if(@batch.save) 
      render json: { message: 'success' }
    else 
      render json: { message: 'Unable to edit resource'}
>>>>>>> dacc2c4d214d8bb965aedf90e9f40f3919ee9e54
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:code, :quantity)
  end

  def get_batch
    @batch = Batch.find(params[:id])
  end

<<<<<<< HEAD
  def get_product(slug)
    Product.find_by({slug: slug})
=======
  def get_product
    @product = Product.find_by({slug: params[:barSlug]})
>>>>>>> dacc2c4d214d8bb965aedf90e9f40f3919ee9e54
  end

  def transform_batch_obj(batch)
    @product = batch.product
    return {id: batch[:id], code: batch[:code], quantity: batch[:quantity], best_before: batch[:best_before], sold: batch[:sold], product: @product.name, product_slug: @product.slug}
  end

end