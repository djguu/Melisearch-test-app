Rails.application.routes.draw do
  get '/products/search', to: 'products#search'
  resources :products
end
