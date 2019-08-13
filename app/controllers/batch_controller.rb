class BatchController < ApplicationController 
  before_action :get_batch, only: [:destroy]

  def index
    @batches = Batch.all
    newArray = []
    @batches.map{|b|newArray.push(transform_batch_obj(b))}
    render json: newArray
  end

  def create
    @batch = Batch.new(batch_params)
    @product = get_product(params[:barSlug])
    @batch.sold = 0
    @batch.product = @product
    @batch.best_before = Date.parse(params[:bestBefore])
    if(@batch.save)
      render json: {}
    else
      render json: {message: 'Unable to save'}, status: 400
    end
  end

  def destroy
    if @batch.destroy
      render json: {}
    else
      render json: {message: 'Unable to delete resource'}
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:code, :quantity)
  end

  def get_batch
    @batch = Batch.find(params[:id])
  end

  def get_product(slug)
    Product.find_by({slug: slug})
  end

  def transform_batch_obj(batch)
    @product = batch.product
    return {code: batch[:code], quantity: batch[:quantity], best_before: batch[:best_before], sold: batch[:sold], product: @product.name}
  end

end