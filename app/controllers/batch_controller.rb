class BatchController < ApplicationController 

  def index
    @batches = Batch.all
    render json: @batches
  end

end