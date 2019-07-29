Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :product, param: :slug
  get '/productlist', to: 'product#product_list'
  get '/product/:id/stock', to: 'product#in_stock'
  resources :batch, :order
end
