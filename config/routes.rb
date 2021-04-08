Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "revenue/merchants", to: "revenue#merchants_with_most_revenue"
      get "items/find_all", to: "search#item_find_all"
      get "merchants/most_items", to: "merchants#with_most_items_sold"
      get "merchants/find", to: "search#merchant_find_one"
      get "revenue/unshipped", to: "revenue#unshipped"
      get "revenue/merchants/:id", to: 'revenue#total_revenue'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items do
        resources :merchant, only: [:index], controller: :item_merchants
      end
    end
  end
end
