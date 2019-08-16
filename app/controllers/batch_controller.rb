class BatchController < ApplicationController 
  before_action :get_batch, only: :show

  def index
    @batches = Batch.all
    newArray = []
    @batches.map{|b|newArray.push(transformBatchObj(b))}
    render json: newArray
  end

  def create
    @batch = Batch.new(batch_params)
    @product = getProduct(params[:barSlug])
    @batch.sold = 0
    @batch.product = @product
    @batch.best_before = Date.parse(params[:bestBefore])
    if(@batch.save)
      render json: {}
    else
      render json: {message: 'Unable to save'}, status: 400
    end
  end

  def show
    byebug
    render json: { body: @batch }
  end

  private

  def batch_params
    params.require(:batch).permit(:code, :quantity)
  end

  def get_batch
    @batch = Batch.find(params[:id])
  end

  def getProduct(slug)
    Product.find_by({slug: slug})
  end

  def transformBatchObj(batch)
    @product = batch.product
    return {code: batch[:code], quantity: batch[:quantity], best_before: batch[:best_before], sold: batch[:sold], product: @product.name}
  end

end