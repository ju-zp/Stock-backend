class ProductController < ApplicationController
    before_action :get_product, only: [:show, :update, :destroy, :in_stock, :orders]

    include TransformerHelper

    def index
        @products = Product.all
        @newArray = []
        @products.map{|p| @newArray.push(TransformerHelper::ProductFormat.transform_product p )}
        render json: @newArray
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        if @product.validate 
            if @product.save
                render json: {status: 200}
            else
                render json: {status: 400, message: "Unable to save"}
            end
        else
            render json: { error: @product.errors.messages}, status: :not_acceptable
        end
    end

    def show
        @orderProducts = @product.batches.order({ best_before: :asc })
        @newArr = []
        @orderProducts.map{|b| @newArr.push(TransformerHelper::BatchFormat.transform_batch(b, @product.name))} 
        render json: {product: @product, batches: @newArr, stock: {total: @product.get_total, sold: @product.get_sold, stock: @product.get_stock}}
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
        @newArray = []
        @product.orders.order({ created_at: :desc }).map{|o| @newArray.push(transform_order(o))}
        render json: @newArray
    end

    private 

    def product_params
        params.require(:product).permit(:name, :description, :image_url)
    end

    def get_product
        @product = Product.find_by slug: params[:slug]
    end

    def transform_batch(batch, name)
        {id: batch[:id], code: batch[:code], quantity: batch[:quantity], product: name, product_id: batch[:product_id], best_before: batch[:best_before], sold: batch.get_sold}
    end

    def transform_order(order)
        @batch_orders = order.batch_orders
        @total = @batch_orders.sum{|b| b.quantity}
        {id: order[:id], order_ref: order[:order_ref], item_count: @batch_orders.size, quantity: @total}
    end
end
