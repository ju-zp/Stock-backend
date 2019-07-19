class BatchController < ApplicationController 

  def index
    @batches = Batches.all
    render json: @batches
  end

end