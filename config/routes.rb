Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find", to: "search#merchant_find_one"
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      get "items/find_all", to: "search#item_find_all"
      resources :items do
        resources :merchant, only: [:index], controller: :item_merchants
      end
    end
  end
end
