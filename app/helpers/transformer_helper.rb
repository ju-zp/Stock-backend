module TransformerHelper

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

    def self.transform_batch()
    end
  end
end
