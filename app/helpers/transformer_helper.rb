module TransformerHelper

  class ProductFormat

    def self.transform_product product
      { product: product, stock: product.get_stock }
    end

  end

  class BatchFormat

    def self.transform_batch(batch, name)
        {id: batch[:id], code: batch[:code], quantity: batch[:quantity], product: name, product_id: batch[:product_id], best_before: batch[:best_before], sold: batch.get_sold}
    end

  end

  class OrderFormat

    def self.transform_order(order)
      @batch_orders = order.batch_orders
      @total = @batch_orders.sum{|b| b.quantity}
      {id: order[:id], order_ref: order[:order_ref], item_count: @batch_orders.size, quantity: @total}
    end

  end

  class IngredientFormat

    def self.transform_ingredients(ingredients)
      newArray = []
      ingredients.map do |i|
        newArray.push({name: i.name})
      end
      newArray
    end

    def self.transform_product_ingredients(ingredients)
      newArray = []
      ingredients.map do |i|
        newArray.push(i.name)
      end
      newArray
    end

  end

  class ProductList

    def self.transform_product_info product
      batches = product.batches
      newArr = []

      batches.map do |b|

        if 0 < b.quantity - b.get_sold 
          newArr.push(self.transform_batch b )
        end

      end
      
      if !newArr.empty?
        {product: product[:name], batches: newArr}
      end
    end

    def self.transform_batch batch 
      { code: batch[:code], quantity: batch[:quantity], product_id: batch[:product_id], sold: batch.get_sold}
    end
    
  end

  class Stock

    def self.transform_batch batch 
      if batch[:quantity] - batch.get_sold > 0
        { code: batch[:code], quantity: batch[:quantity], sold: batch.get_sold, stock: batch[:quantity] - batch.get_sold, best_before: batch[:best_before] }
      end
    end

  end

end
