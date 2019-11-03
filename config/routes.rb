Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :product, param: :slug
  get '/productlist', to: 'stock#product_list'
  get '/product/:slug/stock', to: 'stock#in_stock'
  get '/product/:slug/orders', to: 'product#orders'
  get '/product/:slug/ingredients', to: 'product#ingredients'
  get '/ingredient/:name/stock', to: 'ingredient_stock#index'
  post '/ingredient/:name/stock', to: 'ingredient_stock#create'
  resources :batch, :order, :recipe, :ingredient
end
