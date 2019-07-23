class ProductController < ApplicationController
    before_action :get_product, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token

    def index
        @products = Product.all
        render json: @products
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
        @batches = @product.batches
        render json: {product: @product, batches: @product.batches}
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

    def product_list
    end

    private 

    def product_params
        params.require(:product).permit(:name, :description)
    end

    def get_product
        @product = Product.find_by slug: params[:slug]
    end
end
