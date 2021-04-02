Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      #add get request and index action for merchantitems controller
      resources :items
      #add get request and show action for item merchant controller
    end
  end
end
