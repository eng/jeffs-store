Jeffs::Application.routes.draw do
  resources :products
  resources :cart_items do
    collection do
      get 'clear'
    end
  end
  root :to => 'products#index'
end
