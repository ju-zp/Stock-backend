class ProductController < ApplicationController
    before_action :get_product, only: [:show, :update, :destroy, :in_stock, :orders]

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
        recipe = @product.recipe
        orderProducts = @product.batches.order({ best_before: :asc })
        newArr = []
        orderProducts.map{|b| newArr.push(TransformerHelper::BatchFormat.transform_batch(b, @product.name))} 
        render json: {product: @product, recipe: recipe, batches: newArr, stock: {total: @product.get_total, sold: @product.get_sold, stock: @product.get_stock}}
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
        puts newArray
        render json: newArray
    end

    private 

    def product_params
        params.require(:product).permit(:name, :description, :image_url)
    end

    def get_product
        @product = Product.find_by slug: params[:slug]
    end
    
end
