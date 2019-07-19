class BatchController < ApplicationController 

  def index
    @batches = Batch.all
    newArray = []
    @batches.map{|b|newArray.push(transformBatchObj(b))}
    render json: newArray
  end

  private 

  def transformBatchObj(batch)
    @product = batch.product
    return {code: batch[:code], quantity: batch[:quantity], best_before: batch[:best_before], sold: batch[:sold], product: @product}
  end

end