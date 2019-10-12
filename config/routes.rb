Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :product, param: :slug
  get '/productlist', to: 'stock#product_list'
  get '/product/:slug/stock', to: 'stock#in_stock'
  get '/product/:slug/orders', to: 'product#orders'
  resources :batch, :order, :ingredient, :recipe
end
