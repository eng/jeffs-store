Jeffs::Application.routes.draw do
  resources :products
  resources :cart_items

  root :to => 'products#index'
end
