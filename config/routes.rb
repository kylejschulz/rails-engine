Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find_one", to: "search#merchant_find_one"
      get "items/find_all", to: "search#item_find_all"
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items do
        resources :merchants, only: [:show], controller: :item_merchants
      end
    end
  end
end
