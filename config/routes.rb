Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], :merchant_items
      end
      #add get request and index action for merchantitems controller
      resources :items do
        resources :meerchants, only: [:show], :item_merchants
      end
      #add get request and show action for item merchant controller
    end
  end
end
